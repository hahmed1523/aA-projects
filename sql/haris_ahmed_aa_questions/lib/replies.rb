require_relative  './connect.rb'

# Interact with Replies table with Ruby objects

class Reply
    attr_accessor :question_id, :parent_reply_id, :author_id, :body

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| Reply.new(datum)}
    end

    def self.find_by_id (id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE id = ?
        SQL

        Reply.new(data[0])
    end 

    def self.find_by_author_id (author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                replies
            WHERE author_id = ?
        SQL

        data.map {|datum| Reply.new(datum) }
    end 

    def self.find_by_question_id (question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE question_id = ?
        SQL

        data.map {|datum| Reply.new(datum) }
    end

    def self.find_by_parent_id(parent_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
            SELECT
                *
            FROM
                replies
            WHERE parent_reply_id = ?
        SQL

        data.map {|datum| Reply.new(datum) }

    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @author_id = options['author_id']
        @body = options['body']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @author_id, @body)
            INSERT INTO
                replies (question_id, parent_reply_id, author_id, body)
            VALUES
                (?, ?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @author_id, @body, @id)
            UPDATE
                replies
            SET
                question_id = ?, parent_reply_id = ?, author_id = ?, body  = ?
            WHERE
                id = ?
        SQL
    end

    def author
        raise "#{self} not in database" unless @id 
        User.find_by_id(@author_id)
    end

    def question
        raise "#{self} not in database" unless @id 
        Question.find_by_id(@question_id)
    end

    def parent_reply
        raise "This is the parent reply" unless @parent_reply_id
        Reply.find_by_id(@parent_reply_id)
    end

    def child_replies 
        Reply.find_by_parent_id(@id)
    end

end