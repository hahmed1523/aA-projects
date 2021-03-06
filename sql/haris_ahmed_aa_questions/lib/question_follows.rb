require_relative  './connect.rb'
require_relative  './users.rb'
require_relative  './questions.rb'

# Interact with Question_follows table with Ruby objects

class Question_Follow
    attr_accessor :user_id, :question_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map { |datum| Question_Follow.new(datum)}
    end

    def self.find_by_id (id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE id = ?
        SQL

        Question_Follow.new(data[0])
    end

    def self.followers_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            users 
        WHERE id IN (SELECT user_id
                    FROM question_follows
                    WHERE question_id = ?)
        SQL

        data.map {|datum| User.new(datum)}
    end

    def self.most_followed_questions(n)
        data = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT
            q.*
        FROM
            question_follows AS f
        JOIN questions AS q
            ON f.question_id = q.id
        GROUP BY f.question_id
        ORDER BY COUNT(f.question_id) DESC
        LIMIT ?
        SQL

        data.map {|datum| Question.new(datum)}
    end

    def self.followed_questions_for_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            questions 
        WHERE id IN (SELECT question_id
                    FROM question_follows
                    WHERE user_id = ?)
        SQL

        data.map {|datum| Question.new(datum)}
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
                question_follows (user_id, question_id)
            VALUES
                (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @id)
            UPDATE
                question_follows
            SET
                user_id = ?, question_id = ?
            WHERE
                id = ?
        SQL
    end

end