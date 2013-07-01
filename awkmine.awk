#!/bin/awk -f term.awk -f 

BEGIN {
	false = 0; true = !0
	#dbg2 = true

	board_row = 8
	board_col = 8
	mine_percent = ARGV[1] !=  "" ? ARGV[1] : 15

	srand()
	system("stty -echo raw")

	term_hidden_cursor()

	curs_row = curs_col = 1

	set_mine()
	set_num()

	for ( ; ; ) {
		disp()
		judge()
		print ""
		key = term_getkey2()
		if (key == "q") {
			Exit(0)
		} else if (key == "j") {
			curs_row = ++curs_row > board_row ? board_row : curs_row
		} else if (key == "k") {
			curs_row = --curs_row < 1 ? 1 : curs_row
		} else if (key == "l") {
			curs_col = ++curs_col > board_col ? board_col : curs_col
		} else if (key == "h") {
			curs_col = --curs_col < 1 ? 1 : curs_col
		} else if (key == "g") {
			curs_row = 1
		} else if (key == "G") {
			curs_row = board_row
		} else if (key == "0") {
			curs_col = 1
		} else if (key == "$") {
			curs_col = board_col
		} else if (key == " ") {
			open(curs_row, curs_col)
		} else if (key == "f") {
			disp_cell[curs_row, curs_col] = "F"
		}
	}
}

function judge()
{
	if (open_cell_num == board_row * board_col - bomb_num) {
		win = true
		disp()
		term_reset()
		system("stty sane")
		print ""
		print "*****************"
		print "*               *"
		print "* You are win!! *"
		print "*               *"
		print "*****************"
		print ""; print ""
		Exit(0)
	}
}

function Exit(code)
{
	system("stty sane")
	exit code
}

function open(row, col)
{
	disp_cell[row, col] = cell[row, col]
	open_cell_num++
	if (cell[row, col] == "*")  {
		ecplosion = true
		all_open()
		disp()
		term_reset()
		system("stty sane")
		print ""
		print "!!!!!!!!!!!!!!!!!"
		print "!               !"
		print "! Explosion!!!! !"
		print "!               !"
		print "!!!!!!!!!!!!!!!!!"
		print ""; print ""
		Exit(0)
	} else if (cell[row, col] == "-")  {
		if (cell[row - 1, col    ] != "*" && disp_cell[row - 1, col    ] == "X")
			open(row - 1, col    )
		if (cell[row + 1, col    ] != "*" && disp_cell[row + 1, col    ] == "X")
			open(row + 1, col    )
		if (cell[row    , col - 1] != "*" && disp_cell[row    , col - 1] == "X")
			open(row    , col - 1)
		if (cell[row    , col + 1] != "*" && disp_cell[row    , col + 1] == "X")
			open(row    , col + 1)
	}
}

function all_open(    i, j)
{
	for (i = 1; i <= board_row; i++)
		for (j = 1; j <= board_row; j++)
			disp_cell[i, j] = cell[i, j]
}

function set_mine(    i, j)
{
	for (i = 0; i <= board_row + 1; i++) {
		for (j = 0; j <= board_row + 1; j++) {
			if (i == 0 || i == board_row + 1 || j == 0 || j == board_col + 1) {
				cell[i, j] = "-"
				disp_cell[i, j] = cell[i, j]
			} else  {
				#cell[i, j] = rand() * 100 > mine_percent ? "-" : "*"
				if (rand() * 100 > mine_percent) {
					cell[i, j] = "-"
				} else {
					cell[i, j] = "*"
					bomb_num++
				}
				disp_cell[i, j] = "X"
			}
		}
	}
}

function set_num(    i, j, n)
{
	for (i = 1; i <= board_row; i++) {
		for (j = 1; j <= board_row; j++) {
			if (cell[i, j] != "*") {
				n = 0
				n += cell[i - 1, j - 1] == "*" ? 1 : 0
				n += cell[i - 1, j    ] == "*" ? 1 : 0
				n += cell[i - 1, j + 1] == "*" ? 1 : 0
				n += cell[i    , j - 1] == "*" ? 1 : 0
				n += cell[i    , j + 1] == "*" ? 1 : 0
				n += cell[i + 1, j - 1] == "*" ? 1 : 0
				n += cell[i + 1, j    ] == "*" ? 1 : 0
				n += cell[i + 1, j + 1] == "*" ? 1 : 0
				cell[i, j] = n ? n : "-"
			}
		}
	}
}

function disp(    i, j)
{
	if (dbg2) {
		print ""
	} else  {
		term_clear(); term_cursor_top()
	}

	if (ecplosion) term_fg_red()

	for (i = 1; i <= board_row; i++) {
		for (j = 1; j <= board_row; j++) {
			#printf "%s ", cell[i, j]
			#printf "%s%s%s ", (i == curs_row && j == curs_col) ? term_fg_cyan() : "", cell[i, j], term_reset()
			#if ( i == curs_row && j == curs_col) { cell[i, j] == " " ? term_bg_cyan() : term_fg_cyan() }
			if ( i == curs_row && j == curs_col) { term_fg_black(); term_bg_yellow() }
			if (ecplosion) term_fg_red()
			if (win) term_fg_cyan()
			if (dbg1) printf "%s", cell[i, j]
			printf "%s", disp_cell[i, j]
			term_reset()
			if (ecplosion) term_fg_red()
			if (win) term_fg_cyan()
			printf " "
		}
		#print ""
		term_cursor_down()
		term_cursor_left(board_row * 2)
	}
}
