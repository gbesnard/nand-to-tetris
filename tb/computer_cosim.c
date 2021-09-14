#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <ncurses.h>

#define NB_VIRTUAL_REGS 16
#define NB_SCREEN_PIXELS 1024

#define REFRESH_RATE 0.1      /* refresh rate in seconds */

extern int ghdl_main (int argc, char **argv);

static int keyboard_input = 0;

static int virtual_registers[NB_VIRTUAL_REGS] = {0};
static int pc_register = 0;
static int a_register = 0;
static int d_register = 0;
static int key_register = 0;
static int screen_pixels[NB_SCREEN_PIXELS] = {0};

/**
 * VHPIDIRECT set virtual registers.
 */
void set_regs(int *regs) 
{	
	unsigned i;

	for (i = 0; i < NB_VIRTUAL_REGS; i++)
	{
		virtual_registers[i] = regs[i];
	}
}

/**
 * VHPIDIRECT set PC register.
 */
void set_pc_reg(int reg) 
{	
	pc_register = reg;
}

/**
 * VHPIDIRECT set A register.
 */
void set_a_reg(int reg) 
{	
	a_register = reg;
}

/**
 * VHPIDIRECT set D register.
 */
void set_d_reg(int reg) 
{	
	d_register = reg;
}

/**
 * VHPIDIRECT set screen pixels.
 */
void set_screen(int *pixels) 
{	
	unsigned i;

	for (i = 0; i < NB_SCREEN_PIXELS; i++)
	{
		screen_pixels[i] = pixels[i];		
	}
}

/**
 * GHDL simulation thread running function.
 */
static void * ghdl_simulation(void *arg)
{
	char* args[] = 
	{ 
		NULL,
		"--ieee-asserts=disable-at-0" 
	};

	(void)arg; /* Unused. */

	ghdl_main(2, args);

	return NULL;
}

/**
 * Keyboard handle thread function.
 */
static void * handle_keyboard_input(void *arg)
{
	int c;

	(void)arg; /* Unused. */

	/* 500 ms timeout for getch. */
	timeout(500);

	while (1)
	{		
		c = getch();
		if (c != ERR) 
		{
			keyboard_input = c;			
		} 
		else 
		{
			keyboard_input = 0;
		}		

		// nanosleep(&ts, NULL);		
	}

	return NULL;
}

/**
 * Create an ncurses window.
 */
WINDOW *create_newwin(int height, int width, int starty, int startx)
{	
	WINDOW *local_win;

	local_win = newwin(height, width, starty, startx);

	/* 0, 0 gives default characters for the vertical and horizontal lines */
	box(local_win, 0 , 0);
	
	/* Show that box. */
	wrefresh(local_win);

	return local_win;
}

/**
 * Destroy an ncurses window.
 */
void destroy_win(WINDOW *local_win)
{	
	/* box(local_win, ' ', ' '); : This won't produce the desired
	 * result of erasing the window. It will leave it's four corners 
	 * and so an ugly remnant of window. */
	wborder(local_win, ' ', ' ', ' ',' ',' ',' ',' ',' ');

	/* The parameters taken are 
	 * 1. win: the window on which to operate
	 * 2. ls: character to be used for the left side of the window 
	 * 3. rs: character to be used for the right side of the window 
	 * 4. ts: character to be used for the top side of the window 
	 * 5. bs: character to be used for the bottom side of the window 
	 * 6. tl: character to be used for the top left corner of the window 
	 * 7. tr: character to be used for the top right corner of the window 
	 * 8. bl: character to be used for the bottom left corner of the window 
	 * 9. br: character to be used for the bottom right corner of the window */
	wrefresh(local_win);
	delwin(local_win);
}

/**
 * Entry point.
 */
int main(void) 
{
	unsigned i;
	char print_char[2];

	pthread_t ghdl_simulation_thread, keyboard_thread;
	WINDOW *win_screen;
	WINDOW *win_dbg;

  	/* Struct for nanosleep. */
	struct timespec ts;

	ts.tv_sec = (time_t) REFRESH_RATE;
	ts.tv_nsec = (long) ((REFRESH_RATE - ts.tv_sec) * 1e+9);

	pthread_create(&ghdl_simulation_thread, NULL, ghdl_simulation, NULL);
	
	/* Init ncurses. */
	initscr();
    clear();
    noecho();	
    cbreak();   /* Line buffering disabled. pass on everything. */
	curs_set(0); /* Invisible cursor. */
	keypad(stdscr, TRUE);		/* Used to get key strokes such as F1 */

    refresh();

	pthread_create(&keyboard_thread, NULL, handle_keyboard_input, NULL);
		
	/* Create two mains windows. */
	win_screen = create_newwin(16 + 2, 64 + 2, 0, 6);
	win_dbg = create_newwin(6, 80, 16 + 2, 0);
	
	mvprintw(15 + 2, 8, "HACK COMPUTER, KHBX SYSTEM");	
	refresh();

	/* Main display loop. */
    while(1)
    {
		/* Print screen. */
		for (i = 0; i < NB_SCREEN_PIXELS; i++)
		{
			print_char[0] = (screen_pixels[i] == 1) ? '#' : ' ';
			print_char[1] = 0;
			mvwprintw(win_screen, 1 + (i / 64), 1 + (i % 64), print_char);			
		}

		/* Print virtual registers values. */
		mvwprintw(win_dbg, 1+0, 2,  "PC : %6d ", pc_register);
       	mvwprintw(win_dbg, 1+1, 2,  "A  : %6d ", a_register);
       	mvwprintw(win_dbg, 1+2, 2,  "D  : %6d ", d_register);
       	mvwprintw(win_dbg, 1+3, 2,  "KEY: %6d ", keyboard_input); // TODO: should be keyboard register
       	mvwprintw(win_dbg, 1+0, 18, "R0 : %6d ", virtual_registers[0]);
       	mvwprintw(win_dbg, 1+1, 18, "R1 : %6d ", virtual_registers[1]);
       	mvwprintw(win_dbg, 1+2, 18, "R2 : %6d ", virtual_registers[2]);
       	mvwprintw(win_dbg, 1+3, 18, "R3 : %6d ", virtual_registers[3]);
       	mvwprintw(win_dbg, 1+0, 34, "R4 : %6d ", virtual_registers[4]);
       	mvwprintw(win_dbg, 1+1, 34, "R5 : %6d ", virtual_registers[5]);
       	mvwprintw(win_dbg, 1+2, 34, "R6 : %6d ", virtual_registers[6]);
       	mvwprintw(win_dbg, 1+3, 34, "R7 : %6d ", virtual_registers[7]);
       	mvwprintw(win_dbg, 1+0, 50, "R8 : %6d ", virtual_registers[8]);
       	mvwprintw(win_dbg, 1+1, 50, "R9 : %6d ", virtual_registers[9]);
       	mvwprintw(win_dbg, 1+2, 50, "R10: %6d ", virtual_registers[10]);
       	mvwprintw(win_dbg, 1+3, 50, "R11: %6d ", virtual_registers[11]);
       	mvwprintw(win_dbg, 1+0, 66, "R12: %6d ", virtual_registers[12]);
       	mvwprintw(win_dbg, 1+1, 66, "R13: %6d ", virtual_registers[13]);
       	mvwprintw(win_dbg, 1+2, 66, "R14: %6d ", virtual_registers[14]);
       	mvwprintw(win_dbg, 1+3, 66, "R15: %6d ", virtual_registers[14]);

        wrefresh(win_screen);
        wrefresh(win_dbg);	

		nanosleep(&ts, NULL);
    }

    clrtoeol();
    refresh();
    endwin();
    return 0;
}
