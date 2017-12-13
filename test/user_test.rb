require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/user'

class UserTest < Minitest::Test
  def test_it_exists
    sal = User.new("Sal")

    assert_instance_of User, sal
  end

  def test_it_has_a_name
    sal = User.new("Sal")

    assert_equal "Sal", sal.name
  end

  def test_it_can_have_another_name
    ali = User.new("Ali")

    assert_equal "Ali", ali.name
  end

  def test_starts_with_no_jokes
    sal = User.new("Sal")
    ali = User.new("Ali")

    assert_equal [], sal.jokes
    assert_equal [], ali.jokes
  end

  def test_user_can_learn_jokes
    sal = User.new("Sal")
    joke = Joke.new({id: 1, question: "Why did the strawberry cross the road?", answer: "Because his mother was in a jam."})
    sal.learn(joke)

    assert_instance_of Array, sal.jokes
    assert_instance_of Joke, sal.jokes[0]
    assert_equal 1, sal.jokes.count
    assert_equal joke, sal.jokes[0]
  end

  def test_user_tell_jokes_to_friends
    sal = User.new("Sal")
    ali = User.new("Ali")
    joke = Joke.new({id: 1, question: "Why did the strawberry cross the road?", answer: "Because his mother was in a jam."})
    sal.learn(joke)
    sal.tell(ali, joke)

    assert_instance_of Array, ali.jokes
    assert_instance_of Joke, ali.jokes[0]
    assert_equal 1, ali.jokes.count
    assert_equal joke, ali.jokes[0]
  end

  def test_users_can_perform_routines_for_friends_who_learn_new_jokes
    ilana = User.new("Ilana")
    josh = User.new("Josh")
    joke_1 = Joke.new({id: 1, question: "Why did the strawberry cross the road?", answer: "Because his mother was in a jam."})
    joke_2 = Joke.new({id: 2, question: "How do you keep a lion from charging?", answer: "Take away its credit cards."})

    ilana.learn(joke_1)
    ilana.learn(joke_2)
    ilana.perform_routine_for(josh)

    assert_equal 2, josh.jokes.count
    assert_equal joke_1, josh.jokes[0]
    assert_equal joke_2, josh.jokes[1]
  end

  def test_user_can_learn_routines
    casey = User.new("Casey")
    casey.learn_routine('./jokes.csv')

    assert_equal 100, casey.jokes.count
    assert_equal 50, casey.jokes[49].id.to_i
    assert_equal "What’s brown and sticky?", casey.jokes[49].question
    assert_equal "A stick", casey.jokes[49].answer
    assert_equal 78, casey.jokes[77].id.to_i
    assert_equal "What kind of star could hurt you?", casey.jokes[77].question
    assert_equal "A shooting star.", casey.jokes[77].answer
  end

end
