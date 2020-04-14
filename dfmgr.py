#!/bin/python3
import os

# get app name
# default special dirs its $HOME and $HOME/.config
# onlyfiles = 
# [f for f in os.listdir("VIM") if os.path.isfile(os.path.join("VIM", f))]
# onlydirs = 
# [d for d in os.listdir("VIM") if os.path.isdir(os.path.join("VIM", d))]
class symfile:
	def __init__(self, name):
		self.name = name
		self.specialPaths=[".config"]

	def get_all_paths(self):
		self.paths = os.listdir(self.name)
		for path in self.specialPaths:
			self.paths.remove(path)

if __name__ == "__main__":
	myfile="VIM"
	a=symfile(myfile)
	a.get_all_paths()


