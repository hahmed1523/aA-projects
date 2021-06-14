require_relative  './connect.rb'
require_relative  './users.rb'
require_relative  './questions.rb'

# Interact with Questions_likes table with Ruby objects

class Question_Like
    attr_accessor :user_id, :question_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map { |datum| Question_Like.new(datum)}
    end

    def self.find_by_id (id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE id = ?
        SQL

        Question_Like.new(data[0])
    end 

    def self.likers_for_question_id (question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                u.*
            FROM
                question_likes AS l
            JOIN users AS u
                ON l.user_id = u.id
            WHERE question_id = ?
        SQL

        data.map { |datum| User.new(datum) }
    end 

    def self.num_likes_for_question_id (question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                COUNT(*) AS total
            FROM
                question_likes
            WHERE question_id = ?
        SQL

        data[0]['total']
    end

    def self.liked_questions_for_user_id (user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                q.*
            FROM
                question_likes AS l
            JOIN questions AS q
                ON l.question_id = q.id
            WHERE l.user_id = ?
        SQL

        data.map { |datum| Question.new(datum) }
    end 

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

    def create
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id)
            INSERT INTO
                question_likes (user_id, question_id)
            VALUES
                (?, ?)      
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @id)
            UPDATE
                question_likes
            SET
                user_id = ?, question_id = ?
            WHERE
                id = ?
        SQL
    end
end