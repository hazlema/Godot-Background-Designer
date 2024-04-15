extends Node

signal loadBackground(item:background)

func sendLoadBackground(item : background):
	loadBackground.emit(item)
