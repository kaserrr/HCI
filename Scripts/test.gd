extends Node

func _ready():
	for tracker in XRServer.get_trackers(XRServer.TRACKER_ANY_KNOWN):
		print(tracker.get_name())
