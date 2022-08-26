########################################
### Welcome to mooD Editing Tutorial ###
########################################

# Here you will learn how to:
# - Do better navigation
# - Do better search/replace
# - Learn how to use the awesome text objects

# This tutorial is recommended only after vimtutor.
# To access vimtutor, type vimtutor on terminal.

# Commands to navigate use in this tutorial:
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

# Command to run: f,ldaajyyplMemail<ESC>MM
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
# df = Delete until and

# Commands to run: df_f'ca'first_name<SPACE><ESC>f[ds[di{

my_array = [{ name: 'otavio schwanck' }, [{ name: 'thiago ribeiro' }]] # << Start

# Code Goal:
array = [{ name: first_name }, {}]


































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

# Commands to run: ct.Mood<ESC>f,yi(lvf,fdjvi(p<C-p><C-p>

value = Charge::Name.new(name, last_name, email, document_number) # << Start
old_args(invalid_args)

# Code Goal:
Mood.new(name, document_number)
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






















# Exercise 6 - The indentation text object (i just love it)
# dii = delete inside identation (text object) (you can use viic too)
# dai = delete around identation (you can use vaic too)
# cii = change inside identation
# K (while in visual mode) = move selection up (can use J to move down)
# [m = go to previous method definition
# Commands: [m3jciitrue<ESC>vaiK<ESC>jjcai<ENTER>for_the_win(true<ESC>
def my_code
  if sometuing
    mood do
      # do 2
      # do 3
    end
    # do 2
    # do 3
  end # << Start
end

# Code Goal:
def my_code
  mood do
    true
  end

  for_the_win(true)
end


















# Exercise 7 - Split / Join
# Commands:
# This basically joins or split anything, can be tags, blocks, ternay
# gS = Split
# gJ

# Tip: go see the goal with j, then press zr to come to the top again
# commands gS/block<ENTER>gJj-gJj0f[gS
mood? ? 'awesome, best editor' : 'please, install mood nvim!' # << STart
block_to_be_joined.each do |b|
  b.save
end
must_be_joined = {
  one: 'one',
  two: 'two'
}
must_be_splitted = ["one", "two"]

# Goal:
if mood?
  'awesome, best editor'
else
  'please, install mood nvim!'
end
block_to_be_joined.each(&:save)
must_be_joined = { one: 'one', two: 'two' }
must_be_splitted = [
  "one",
  "two"
]























# Exercise 8 - Snippets and more snippets!
# Snippets are awesome. Lets learn how to do in mooD.
# Unlike other editor, to expand a snippet (and go forward), is <Ctrl + j>
# TIP: Too see snippets list, just press SPC h s
# <C-j> = Expand / Go forward on snippets
# <C-k> = Go back on snippets
# <Delete> = Delete highlighted text on snippets
# Commands; jidesc<C-j>#mood<C-j>letm<C-j>mood<C-j><C-j>name:<SPACE>'true'<C-j><Enter><Enter>contw<C-j>valid<C-j>itiexp<C-j><ESC>

# << Start Here

# Goal:
describe '#mood' do
  let(:mood) { create(:mood, name: 'true') }

  context 'when valid' do
    it { is_expected.to be_valid }
  end
end























# Exercise 9 - Just a warning
# This exercise is just to remember you:  DONT USE ARROWS ON INSERT MODE (or any more) (this is for you Thiago!),
# use w, e, b, f, t, s, etc..
# to select stuff, use v, or V and the text objects
#
# # << Start














































# Exercise 10 - Search and Replace on block
# Commands: vij = select block
#           s/old_text/new_text/gr = changes texts from the block. If you type \0 on old, it will get the current text
# Commands to execute: vij:s/john/new_\0_is_awesome/gr<ENTER>
{
  name: john, last_name: john, # << Start
  email: john, cpf: john,
  cnpj: john
}

# Code Goal:
{
  name: new_john_is_awesome, last_name: new_john_is_awesome,
  email: new_john_is_awesome, cpf: new_john_is_awesome,
  cnpj: new_john_is_awesome
}
















































# Exercise 11: Macros (Boss Fight)
#
# Commands:

# q + key = Start recording macro
# q = stop macro (when macro running)
# @ + key = Execute macro saved on key
# SPC m n = turn selection (or word) to snake case
# %s/old_new/gre = The letter `e` at the end is very important, it prevent catch errors on substitute (not all lines need in this code)
# This is very useful to when you copy some CSVs, tables, etc from a website to your code and need to parse!
# Commands to execute: jqqxxv-:s/ /_/gre<ENTER><SPACE>nsI:<ESC>A,<ESC>j0q@q@q@q
# IMPORTANT: Is good practice to end macros in the place that needs to be executed later!
# << Start
# Rio Grande do Sul
# Rio GrandeDo Norte
# Bahia
# Brasilia

# Goal:
:rio_grande_do_sul,
:rio_grandedo_norte,
:bahia
:brasil
