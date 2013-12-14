local class = require 'middleclass.middleclass'
require 'events.LeftEvent'
require 'events.RightEvent'
require 'events.StopEvent'
require 'events.DestroyEvent'
require 'events.TickEvent'

Event = class('events.Event')

function Event:apply(state)
end