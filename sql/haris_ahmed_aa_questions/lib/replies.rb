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
end