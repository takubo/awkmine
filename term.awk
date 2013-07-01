# Miscellaneous

function term_clear()
{
	printf "\033[2J"
}

function term_reset()
{
	printf "\033[00m"
}

function term_bold()
{
	printf "\033[01m"
}


# Foreground Color

function term_fg_color(color)
{
	if (color == "black") {
		printf "\033[30m"
	} else if (color == "red") {
		printf "\033[31m"
	} else if (color == "green") {
		printf "\033[32m"
	} else if (color == "yellow") {
		printf "\033[33m"
	} else if (color == "blue") {
		printf "\033[34m"
	} else if (color == "magenta") {
		printf "\033[35m"
	} else if (color == "cyan") {
		printf "\033[36m"
	} else if (color == "white") {
		printf "\033[37m"
	}
	return
}

function term_fg_black() { printf "\033[30m" }

function term_fg_red() { printf "\033[31m" }

function term_fg_green() { printf "\033[32m" }

function term_fg_yellow() { printf "\033[33m" }

function term_fg_blue() { printf "\033[34m" }

function term_fg_magenta() { printf "\033[35m" }

function term_fg_cyan() { printf "\033[36m" }

function term_fg_white() { printf "\033[37m" }


# Background Color

function term_bg_color(color)
{
	if (color == "black") {
		printf "\033[40m"
	} else if (color == "red") {
		printf "\033[41m"
	} else if (color == "green") {
		printf "\033[42m"
	} else if (color == "yellow") {
		printf "\033[43m"
	} else if (color == "blue") {
		printf "\033[44m"
	} else if (color == "magenta") {
		printf "\033[45m"
	} else if (color == "cyan") {
		printf "\033[46m"
	} else if (color == "white") {
		printf "\033[47m"
	}
	return
}

function term_bg_black() { printf "\033[40m" }

function term_bg_red() { printf "\033[41m" }

function term_bg_green() { printf "\033[42m" }

function term_bg_yellow() { printf "\033[43m" }

function term_bg_blue() { printf "\033[44m" }

function term_bg_magenta() { printf "\033[45m" }

function term_bg_cyan() { printf "\033[46m" }

function term_bg_white() { printf "\033[47m" }


# Cursor Control

function term_hidden_cursor()
{
	printf "\033[>5h"
}

function term_show_cursor()
{
	printf "\033[>5l"
}


# Cursor Move

function term_cursor_up(n)
{
	printf "\033[%dA", n
}

function term_cursor_down(n)
{
	printf "\033[%dB", n
}

function term_cursor_right(n)
{
	printf "\033[%dC", n
}

function term_cursor_left(n)
{
	printf "\033[%dD", n
}

function term_cursor_move(row, col)
{
	printf "\033[%d;%dH", row, col
}

function term_cursor_top()
{
	printf "\033[0;0H"
}

# Key input
function term_getkey(    key)
{
	"stty -echo raw; dd bs=1 count=1 2>/dev/null; stty cooked echo" | getline key
	close("stty -echo raw; dd bs=1 count=1 2>/dev/null; stty cooked echo")
	return  key
}

# Key input
function term_getkey2(    key)
{
	"dd bs=1 count=1 2>/dev/null" | getline key
	close("dd bs=1 count=1 2>/dev/null")
	return  key
}
