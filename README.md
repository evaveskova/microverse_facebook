# Microverse Facebook Project

<img src="https://res.cloudinary.com/it-s-tech/image/upload/v1586209145/Screenshot_from_2020-04-06_22-37-14_ztwoa7.png">

### About
This app was built to have similar functionalities to Facebook, wherein users can sign up for a new account or sign in with their own Facebook account, create posts, like and comment on others' posts, and send friend requests to other users. You can see the project requirements on [the Odin Project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project).

### Live Demo 
Click [here](https://still-ridge-12937.herokuapp.com/) to see the live version.

### Demo Video
Click [here](https://res.cloudinary.com/it-s-tech/video/upload/v1586277556/facebook_xqmqpm.mp4) to watch a demo video.

### Technologies Used.

* Ruby 2.6.4
* Rails 5.2.3
* PostgreSQL 11.5
* Devise 4.7.1
* OmniAuth 5.0
* Bootstrap 4.3.1
* Sass 5.0
* RSpec 3.9
* Capybara 2.15

### Installation And Usage

* Clone the repository using the command:
```
git@github.com:evaveskova/microverse_facebook.git
```
* Install the gems using the command:

```
$ bundle install
```

* Migrate the database using the command:

``` 
rails db:migrate
```

* Run the development server using the command:
```
rails s
```
### Testing
* To test models:
```
rspec spec/models
```
* To test features:
```
rspec spec/features
```

### Deployment On Heroku
* Create a [Heroku](https://dashboard.heroku.com/) account.
* Install [Heroku CLI](https://dashboard.heroku.com/) on your computer.
* Login to Heroku from your terminal using the command: <br>
  ```heroku login```
* Enter your credentials as the above command will prompt you.
* Cd to the root folder of your project.
* Create a Heroku app using the command: <br> 
  ```heroku create <name-of-you-app> ```
* Commit your work and push to github. <br> 
```
  git add .
  git commit -m"commit-message"
  git push origin master
```
* Deploy your work to Heroku using the command: <br>
``` git push Heroku master```
* To see your hosted application on the browser, type the command: <br>
``` heroku open```

### Future Features
* Using Ajax to retrieve comments and post rather than reloading the page all the time.
* Implementing birthday notification.

### Authors
:bust_in_silhouette: [Nyaga Andre Roy](https://github.com/RoyNyaga)
* Gihub: [RoyNyaga](https://github.com/RoyNyaga)
* Email: [nyagaandreroy@gmail.com](mailto:nyagaandreroy@gmail.com)
* Linkedin: [Roy Nyaga](https://www.linkedin.com/in/roy-nyaga-andre/)

:bust_in_silhouette: [Eva Aleksandra Veskova Jackson](https://github.com/evaveskova/)
* Gihub: [Eva Aleksandra Veskova Jackson](https://github.com/evaveskova/)
* Email: [nyagaandreroy@gmail.com](mailto:mailto:evaveskova@gmail.com)
* Linkedin: [evaveskova](linkedin.com/in/evaveskova)

