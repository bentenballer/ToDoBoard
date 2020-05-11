require_relative "item"

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = "")
        if Item.new(title, deadline, description)
            @items << Item.new(title, deadline, description)
            true
        else
            false
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        index > -1 && index < @items.length
    end

    def swap(index_1, index_2)
        if self.valid_index?(index_1) == false || self.valid_index?(index_2) == false
            false
        else
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            true
        end
    end

    def [](index)
        if self.valid_index?(index) == false
            return nil
        end
        @items[index]
    end

    def priority
        @items[0]
    end
    
    def print
        puts "".ljust(45, "-")
        puts self.label.ljust(45)
        puts "".ljust(45, "-")
        puts "Index".ljust(6) + "| Item".ljust(14)+"| Deadline".ljust(20) +"| Done".ljust(5)
        @items.each_with_index do |item, idx|
            printf "#{idx}".ljust(6) + "| #{item.title}".ljust(14)+"| #{item.deadline}".ljust(20)
            if item.done == true
                puts "| [x]".ljust(5)
            else
                puts "| []".ljust(5)
            end
        end
    end

    def print_full_item(index)
        if self.valid_index?(index)
            puts "".ljust(40, "-")
            printf "#{self[index].title}".ljust(25) + "#{self[index].deadline}".ljust(10)
            if self[index].done == true
                puts "[x]".ljust(5)
            else
                puts "[]".ljust(5)
            end
            puts "#{self[index].description}".ljust(40)
            puts "".ljust(40, "-")
        end
    end

    def print_priority
        puts "".ljust(40, "-")
        printf "#{self[0].title}".ljust(25) + "#{self[0].deadline}".ljust(10)
        if self[0].done == true
                puts "[x]".ljust(5)
            else
                puts "[]".ljust(5)
            end
        puts "#{self[0].description}".ljust(40)
        puts "".ljust(40, "-")
    end

    def up(index, amount = 1)
        if self.valid_index?(index)
            i = 0
            while i < amount
                pos = index - i
                if pos > 0
                    swap(pos, pos - 1)
                end
                i += 1
            end
            return true
        end
        false
    end

    def down(index, amount = 1)
        if self.valid_index?(index)
            i = 0
            while i < amount
                pos = index + i
                if pos < @items.length - 1
                    swap(pos, pos + 1)
                end
                i += 1
            end
            return true
        end
        false
    end

    def sort_by_date!
        @items.sort_by! {|item| item.deadline }
    end

    def toggle_item(index)
        if self.valid_index?(index)
            @items[index].toggle
            return true
        end
        false
    end

    def remove_item(index)
        if self.valid_index?(index)
            if index == @items.length - 1
                @items = @items[0...index]
            else
                @items = @items[0...index] + @items[index + 1..-1]
            end
            return true
        end
        false
    end

    def purge
        i = 0
        while i < @items.length
            if @items[i].done
                remove_item(i)
            else
                i += 1
            end
        end
    end
end