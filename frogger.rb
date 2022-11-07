require 'ruby2d'

set width: 400, height: 400

Rectangle.new(width: 400, height: 50, x: 0, y: 250, color: 'gray')
frog = Square.new(size: 50, color: 'olive', x: 200, y: 350)

taxis = []
taxis << Rectangle.new(width: 80, height: 40, x: 400, y: 255, color: 'yellow')
taxis << Rectangle.new(width: 80, height: 40, x: 200, y: 255, color: 'yellow')

gamestate = 'playing'
message = nil

on :key_down do |event|
  puts event.key
  if gamestate == 'playing'
    if event.key == 'left'
      frog.x = frog.x - 50
    elsif event.key == 'right'
      frog.x = frog.x + 50
    elsif event.key == 'up'
      frog.y = frog.y - 50
    elsif event.key == 'down'    
      frog.y = frog.y + 50
    end
  end
  if event.key == 'backspace'
    gamestate = 'playing'
    message.remove
    frog.color = 'olive'
    frog.x = 200
    frog.y = 350
  end
end

tick = 0

update do
  if gamestate == 'playing'
    tick = tick + 1
    if tick % 120 == 0
      # create new taxi
      taxis << Rectangle.new(width: 80, height: 40, x: 400, y: 255, color: 'yellow')
    end
    if frog.y == 0
      gamestate = 'won'
      message = Text.new('You won!', x: 150, y: 100, color: 'purple', size: 42)
    end
    taxis.each do |taxi|
      taxi.x = taxi.x - 2
      # Has the taxi hit a frog?
      if ((frog.y + 5 == taxi.y) && (frog.x < taxi.x + taxi.width) && (frog.x + frog.width > taxi.x))
        frog.color = 'red'
        gamestate = 'lost'
        message = Text.new('You lost!', x: 150, y: 100, color: 'red', size: 42)
      end
    end
  end
end

show