require_relative  './connect.rb'
require_relative  './users.rb'
require_relative  './replies.rb'
require_relative  './question_follows.rb'

# Interact with Questions table with Ruby objects

class Question
    attr_accessor :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Question.new(datum)}
    end

    def self.find_by_id (id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE id = ?
        SQL

        Question.new(data[0])
    end

    def self.find_by_author_id (author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE author_id = ?
        SQL

        data.map {|datum| Question.new(datum)}
    end

    def self.most_followed(n)
        Question_Follow.most_followed_questions(n)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
            INSERT INTO
                questions (title,body, author_id)
            VALUES
                (?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @title, @body,@author_id, @id)
            UPDATE
                questions
            SET
                title = ?, body = ?, author_id = ?
            WHERE
                id = ?
        SQL
    end

    def author
        raise "#{self} not in database" unless @id 
        User.find_by_id(@author_id)
    end

    def replies
        raise "#{self} not in database" unless @id 
        Reply.find_by_question_id(@id)
    end

    def followers
        Question_Follow.followers_for_question_id(@id)
    end

end