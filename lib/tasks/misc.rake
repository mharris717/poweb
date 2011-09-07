task :clear_ratings => [:environment] do
  Rating.destroy_all
end