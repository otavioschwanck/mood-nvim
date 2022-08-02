########################################
### Welcome to mooD Editing Tutorial ###
########################################

# Here you will learn how to:
# - Do better navigation
# - Do better search/replace
# - Learn how to use the awesome text objects

# This tutorial is recommended only after vimtutor.
# To access vimtutor, type vimtutor on terminal.

# Commands to navigate use this tutorial:
# Ctrl + j or zj = Next exercise
# C-k or zk = Previous exercise
# zj = jump to specific exercise by number
# zr = Reset exercise code (you will use this a lot)

# I recommended to do each exercise at least 10 times before move to the next.  Use zr to keep reseting.

# Your goal is to make the marked with << Start equal to the code of bottom.  All the commands are available.

# The most important thing on VIM is:  Dont use the ARROW KEYS.  Insert mode is just for type, not navigate!

# Press Ctrl + j or zj to start



























# Exercise 1 - Find character in line
# Commands we will learn:
# f = go to character (next that you input)
# M = start multiple cursors

# Command to run: f,ldaajyyplMMcemail<ESC>ESC>
def my_method(name, last_name, email) # << Start
  @name = name
end


# Code Goal:
def my_method(name, email)
  @name = name
  @email = email
end




















# Exercise 2 -
# Lets talk about text objects, one of the most cool things on vim.
# text objects are anything on your code that makes sense, a string with "", an array, an argument, etc
#
# You can edit text objects in two ways. with a = around and with i = inside.
# You can pass the action + a or i + text object.
#
# Example: di" = delete inside double quotes.
#
# New commands we gonna learn in this lesson:
# ca' or caq = Change around quotes (text object)
# ds[ = Delete surround [
# di{ = Delete inside keys (text object)

# Commands to run: f'ca'first_name<SPACE><ESC>f[ds[di{

my_array = [{ name: 'otavio schwanck' }, [{ name: 'thiago ribeiro' }]] # << Start

# Code Goal:
array = [{ name: first_name, {} }]


































# Exercise 3 - Until
# One awesome command is t = until.  Its like f, but go to one character before.

# ct = change until (needs 1 more key)
# df = delete until and (needs 1 more key)
# vf, = select until and(needs 1 more key), keep pressing f to keep searching
# yit = yank inside parenthesis (text object)
# x = Delete character at cursor
# vi( = Visual select inside parenthesis
# p while in visual mode (selecting something) = Will substitute selected text with last yank
# <Ctrl + p> (after paste) = Navigate in yank history, you can also use <Ctrl + n> to go back

# Commands to run: df=xct.Mood<ESC>f,yi(lvf,fdjvi(p<C-p>

value = Charge::Name.new(name, last_name, email, document_number) # << Start
old_args(invalid_args)

# Code Goal:
Mood.new(name)
old_args(name, last_name, email, document_number)


































# Exercise 4 - Change delimiters
# Explanation:
#
# cs received two arguments: the old delimiter and the new delimiter
#
# Example: cs"] will change "otavio" to [otavio]
# about brackets, keys and parenthesis, if you use they opening, it will
# add spaces, like [ otavio ].  If you use closing, it will be [otavio]
# The same rule is used for S (add delimiter to selected text)
#
# Commands:
# cs]{ = will change [] to {  } (with spaces)
# S{
# ds] = delete delimiter []
# dt, = delete until comma
# . = repeat last command
# gs = cycle possible stuff (strings to symbols, hash : to =>, always cycling)
# r = change character at cursor to something else
# W = Jump all words until next space, going to first character
#
# Commands ot execute:
# f[cs[{wlrOhvEhS{a<space>name:<SPACE><ESC>f[cs[{a<space>name:<ESC><SPACE>f,dt,..f:gsWgsgs

my_hash = ["otavio", ["tulio"], "wrong 1", "wrong 2", "wrong 3", { :name => "thiagovsk" }] # << Start
# Code Goal:
my_hash = { { name: "otavio" }, { name: "tulio" }, { name: :thiagovsk } }


































# Exercise 5 - Moving arguments around

# you can move arguments left and right with gh and gl.
#
# Commands we will learn:
# gh = swap argument to argument at left
# gl = swap arugment to argument at right
# daa = delete around argument (text object a = argument)
# cia = change inside argument (text object a = arguemnt)
# F = same as f, but backwards (T and S works as well)

# Commands: ftglglF[lglglglF'fghciatwo<ESC>f'daa

args = [three, four, one, 'wrong argument', '!!DELETE ME!!'] # << Start

# Code Goal
args = [one, two, three, four]































# Exercise 6 - Just a warning
# This exercise is just to remember you:  DONT USE ARROWS ON INSERT MODE (or any more) (this is for you Thiago!),
# use w, e, b, f, t, s, etc..
# to select stuff, use v, or V and the text objects
#
# # << Start
