
class PlaneCoord
    def x
        @x
    end

    def y
        @y
    end

    def x=(value)
        @x=value
    end

    def y=(value)
        @y=value
    end
end


class Robot

    def face
        @f
    end

    def face=(value)
        @f=value
    end

    def command
        @command
    end

    def position
        @position
    end

    def initialize
        @coord = PlaneCoord.new
        @coord.x, @coord.y = 0

        @f = String.new
        @ready = true
    end

    def place
        pst = position.split(/,/)

        x, y= pst[0].to_i, pst[1].to_i
        f = pst[2]
        
        # dimensions 5 units x 5 units
        if x < 0 or x > 4 or y < 0 or y > 4
            @ready = false
        else
            @ready = true
            @coord.x, @coord.y, @f = x, y, f
        end
    end

    def ready
        @ready
    end

    def move
        if self.ready == false
            return false
        end

        case self.face
        when "EAST"     then x, y = @coord.x + 1, @coord.y
        when "SOUTH"    then x, y = @coord.x, @coord.y - 1
        when "WEST"     then x, y = @coord.x - 1, @coord.y
        when "NORTH"    then x, y = @coord.x, @coord.y + 1
        else 
            x, y = @coord.x, @coord.y
        end

        if x < 0 or x > 4 or y < 0 or y > 4
            return false
        else
            @coord.x, @coord.y = x, y
        end
    end

    def rotate
        if self.ready == false
            return false
        end

        direction = ["EAST", "SOUTH", "WEST", "NORTH"]
        current = direction.index(@f)
        if @command == "LEFT"
            current = current - 1
        elsif @command == "RIGHT"
            current = current + 1
        end
        self.face = direction.at(current)
    end

    def report
        if self.ready == false
            return "PLACE incorrect"
        else
            return "Output: #{@coord.x.to_s},#{@coord.y.to_s},#{@f}"
        end
    end

    def run(string)
        input = string.upcase.strip.split(/ /)
        @command = input[0]
        @position = input[1]
    end
end

class ToyRobot

    def initialize
        @robot = Robot.new
        @output = String.new
    end

    #def cli
    #    input = gets.upcase.strip.split(/ /)
    #    command = input[0]
    #    position = input[1]
    #    return command, position
    #end

    def fileinput(file)

        if File.exist?(file) == false
            return false
        end

        IO.foreach(file) do |line|
            @robot.run(line)

            case @robot.command
            when "PLACE"            then @robot.place
            when "MOVE"             then @robot.move
            when "LEFT" || "RIGHT"  then @robot.rotate
            when "REPORT"           then @output = @robot.report
            end
        end

        return @output
    end
end
