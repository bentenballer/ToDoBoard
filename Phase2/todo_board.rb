require_relative "list"

class TodoBoard
    def initialize
        @board = {}
    end

    def get_command
        print "\nPlease enter a command: "
        cmd, *args = gets.chomp.split(" ")
        case cmd
        when "mklist"
            @board[*args] = List.new(*args)
        when "ls"
            @board.each_key {|label| puts label}
        when "showall"
            @board.each_key { |label| @board[label].print }
        when 'mktodo'
            label = args[0]
            @board[label].add_item(*args[1..-1].map)
        when 'up'
            label = args[0]
            @board[label].up(*args[1..-1].map{|ele| ele.to_i})
        when 'down'
            label = args[0]
            @board[label].down(*args[1..-1].map{|ele| ele.to_i})
        when 'swap'
            label = args[0]
            @board[label].swap(*args[1..-1].map{|ele| ele.to_i})
        when'sort'
            @board[*args].sort_by_date!
        when 'priority'
            @board[*args].print_priority
        when 'print'
            label = args[0]
            if args[1..-1].empty?
                @board[label].print
            else
                @board[label].print_full_item(*args[1..-1].map{|ele| ele.to_i})
            end
        when 'toggle'
            label = args[0]
            @board[label].toggle_item(*args[1..-1].map{|ele| ele.to_i})
        when 'rm'
            label = args[0]
            @board[label].remove_item(*args[1..-1].map{|ele| ele.to_i})
        when'purge'
            @board[*args].purge
        when 'quit'
            return false
        else
            print "Sorry, that command is not recognized."
        end
        true
    end

    def run
        game = true

        while game
            switch = self.get_command
            if switch == false
                game = false
            end
        end
    end
end

b = TodoBoard.new
b.run