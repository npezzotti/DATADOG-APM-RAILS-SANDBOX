# Datadog APM Quickstart for Rails Application

### This repository is a guide to setting up a basic rails application for APM with datadog. The setup script installs everything you need in your environment to build a rails app- nodejs and npm- as a few Rails features depend on a JavaScript Runtime, rbenv- a ruby version-managment tool, ruby, rails, and sqlite3- the default database rails is configured to use. The Vagrantfile forwards port 3000, where your rails server will run on by default, to 5051 on your local machine.

These are the remaining steps:

1. Clone this repository, `cd` into it,  and run `vagrant up` and then `vagrant ssh`

2. Install the Datadog agent with your API key using the Ubuntu-specific command:
```
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=<YOUR_API_KEY> bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
```

3. In the home directory, run `rails new <YOUR_APPLICATION_NAME>`

4. `cd <YOUR_APPLICATION_NAME>` and create a new file `config/initializers/datadog-tracer.rb` with the following content:
```
Datadog.configure do |c|
  c.use :rails, service_name: 'rails', analytics_enabled: true
end
```
*or*, from the home directory, run `cp /vagrant/data/datadog-tracer.rb <YOUR_APPLICATION_NAME>/config/initializers/datadog-tracer.rb` to copy it over from the shared directory.

5. In <YOUR_APPLICATION_NAME>/Gemfile add the following gem: `gem 'ddtrace'` and run `bundle install`

6. From the root of your project directory, run `rails server -b 0.0.0.0` to start the server without binding it exclusively to the vm. This will allow you to access it in the browser from your host machine.

7. In your browser, navigate to `http://127.0.0.1:5051` to see the homepage on your rails application.

8. Navigate to the traces page of the Datadog app to see traces appearing.
