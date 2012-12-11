# spec/factories/contacts.rb
FactoryGirl.define do

  factory :post do 
    body "content"
    title "title"
  end
  
  factory :invalid_post, parent: :post do
    body nil
    title nil
  end

  factory :user do 
    email "funkymail@list.ru"
    password "111111"
    password_confirmation "111111"
    admin true
  end

end

