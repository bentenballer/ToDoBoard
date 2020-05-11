require_relative "list"

class TodoBoard
    def initialize(label)
        @label = List.new(label)
    end

    def get_command
        print "\nPlease enter a command: "
        cmd, *args = gets.chomp.split(" ")
        case cmd
        when 'mktodo'
            @label.add_item(*args)
        when 'up'
            @label.up(*args.map{|ele| ele.to_i})
        when 'down'
            @label.down(*args.map{|ele| ele.to_i})
        when 'swap'
            @label.swap(*args.map{|ele| ele.to_i})
        when'sort'
            @label.sort_by_date!
        when 'priority'
            @label.print_priority
        when 'print'
            if args.empty?
                @label.print
            else
                @label.print_full_item(*args.map{|ele| ele.to_i})
            end
        when 'quit'
            return false
        else
            print "Sorry, that command is not recognized."
        end
        true
    end

    def run
        puts "List of command:" 
        puts "\nmktodo <title> <deadline> <optional description> -makes a todo with the given information
        \nup <index> <optional amount> -raises the todo up the list
        \ndown <index> <optional amount> -lowers the todo down the list
        \nswap <index_1> <index_2> -swaps the position of todos
        \nsort -sorts the todos by date
        \npriority -prints the todo at the top of the list
        \nprint <optional index> \n-prints all todos if no index is provided
        \n-prints full information of the specified todo if an index is provided
        \nquit -returns false"

        game = true

        while game
            switch = self.get_command
            if switch == false
                game = false
            end
        end
    end
end