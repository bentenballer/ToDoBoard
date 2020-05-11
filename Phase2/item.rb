class Item
    attr_accessor :title, :deadline, :description
    attr_reader :done

    def Item.valid_date?(date_string)
        dates = date_string.split("-")
        month = dates[1].to_i
        day = dates[-1].to_i

        return false if month < 1 || month > 12
        return false if day < 1 || day > 31

        true
    end

    def initialize(title, deadline, description)
        @title = title
        if Item.valid_date?(deadline)
            @deadline = deadline
        else
            raise "Invalid date format!"
        end
        @description = description
        @done = false
    end

    def deadline=(new_deadline)
        if Item.valid_date?(new_deadline)
            @deadline = new_deadline
        else
            raise "Invalid date format!"
        end
    end

    def toggle
        if @done == false
            @done = true
        else
            @done = false
        end
    end
end