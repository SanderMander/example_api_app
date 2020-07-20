if ENV['INIT_SEED']
  # create 3 seasons with 1 episode
  FactoryBot.create_list :episode, 3
  FactoryBot.create_list :movie, 3
  FactoryBot.create_list :user, 3
  FactoryBot.create :purchase
end
