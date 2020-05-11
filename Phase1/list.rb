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
        puts "".ljust(40, "-")
        puts self.label.ljust(40)
        puts "".ljust(40, "-")
        puts "Index".ljust(6) + "| Item".ljust(14)+"| Deadline".ljust(20)
        @items.each_with_index do |item, idx|
            puts "#{idx}".ljust(6) + "| #{item.title}".ljust(14)+"| #{item.deadline}".ljust(20)
        end
    end

    def print_full_item(index)
        if self.valid_index?(index)
            puts "".ljust(40, "-")
            puts "#{self[index].title}".ljust(30) + "#{self[index].deadline}".ljust(10)
            puts "#{self[index].description}".ljust(40)
            puts "".ljust(40, "-")
        end
    end

    def print_priority
        puts "".ljust(40, "-")
        puts "#{self[0].title}".ljust(30) + "#{self[0].deadline}".ljust(10)
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
end