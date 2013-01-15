# spec/factories/contacts.rb
FactoryGirl.define do
  
  factory :photo do
    image 'C:\Sites\paintball\public\uploads\photo\image\33.jpg'
    name 'noname'
  end

  factory :album do
    id 3
    name "some_name"
  end  

  factory :comment do
    user_id 3
    post_id 28
    content "contenthere"
  end  

  factory :invalid_comment, parent: :comment do
    id 3
    user_id 3
    post_id 28
    content ""
  end  

  factory :blank_comment, parent: :comment do
    user_id 3
    post_id nil
    content ""
  end  

  factory :post do 
    id 28
    user_id 1
    body "content"
    title "title"
    video "http://www.youtube.com/watch?v=cPiDloKgsWQ"
  end

  factory :another_post, parent: :post do 
    user_id 2
    body "content"
    title "title"
  end
  
  factory :invalid_post, parent: :post do
    body "  "
    title "   "
  end

  factory :user do
    id 1 
    email "funkymail@list.ru"
    password "111111"
    password_confirmation "111111"
    admin true
  end

  factory :null_user, parent: :user do 
    email ""
    password ""
    admin false
  end

  factory :regular_user, parent: :user do 
    id 3
    email "6667777@list.ru"
    password "111111"
    password_confirmation "111111"
    admin false
  end


end

