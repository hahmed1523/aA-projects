require_relative  './connect.rb'
require_relative  './questions.rb'
require_relative  './replies.rb'
require_relative  './question_follows.rb'
require_relative  './question_likes.rb'

# Interact with Users table with Ruby objects

class User
    attr_accessor :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| User.new(datum)}
    end

    def self.find_by_name (fname, lname)
        data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE fname = ? AND lname = ?
        SQL

        data.map { |datum| User.new(datum) }
    end

    def self.find_by_id (id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE id = ?
        SQL

        User.new(data[0])
    end 

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
            INSERT INTO
                users (fname,lname)
            VALUES
                (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
            UPDATE
                users
            SET
                fname = ?, lname = ?
            WHERE
                id = ?
        SQL
    end

    def authored_questions
        raise "#{self} not in database" unless @id 
        Question.find_by_author_id(@id)
    end

    def authored_replies
        raise "#{self} not in database" unless @id
        Reply.find_by_author_id(@id)
    end

    def followed_questions
        Question_Follow.followed_questions_for_user_id(@id)
    end

    def liked_questions
        Question_Like.liked_questions_for_user_id(@id)
    end

    def average_karma
        raise "#{self} not in database" unless @id
        data = QuestionsDatabase.instance.execute(<<-SQL, @id)

            SELECT AVG(l.total) AS avg
            FROM questions AS q 
            JOIN (SELECT question_id, COUNT(question_id) AS total 
                  FROM question_likes 
                  GROUP BY question_id) AS l
            ON id = l.question_id 
            WHERE author_id = ?
            
        SQL

        data[0]['avg']
        
    end

end