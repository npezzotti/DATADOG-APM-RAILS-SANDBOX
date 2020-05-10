# Datadog APM Quickstart for Rails Application

### This repository is a guide to instrumenting a basic rails application for APM with Datadog on Ubuntu 18.04. The setup script installs everything you need in your environment to build a rails app: nodejs and npm- as a few rails features depend on a javaScript runtime, rbenv- a ruby version-managment tool, ruby, rails, and sqlite3- the default database rails is configured to use. The Vagrantfile forwards port 3000, where your rails server will run on by default, to 5051 on your local machine, for you to access in your browser.

These are the remaining steps:

1. Clone this repository, `cd` into it,  and run `vagrant up` and then `vagrant ssh`

2. Install the Datadog Agent with your API key using the Ubuntu-specific command:
```
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=<YOUR_API_KEY> bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
```
This is all you will need to do to configure the agent, as APM is enabled by default in the agent 6^.

3. In the home directory, run `rails new <YOUR_APPLICATION_NAME>`

4. `cd <YOUR_APPLICATION_NAME>` and create a new file `config/initializers/datadog-tracer.rb` with the following content:
```
Datadog.configure do |c|
  c.use :rails, service_name: 'rails', analytics_enabled: true
end
```
*or*, from the home directory, run `cp /vagrant/data/datadog-tracer.rb <YOUR_APPLICATION_NAME>/config/initializers/datadog-tracer.rb` to copy it over from the shared directory. This file insturments your application to send traces to the Datadog agent using the Ruby APM tracer. It uses the following format:
```
Datadog.configure do |c|
  # Activates and configures an integration
  c.use :integration_name, options
end
```
In the case, we are naming the service "rails" and enabling App Analytics, but there are more [configuration options](https://docs.datadoghq.com/tracing/setup/ruby/#integration-instrumentation) which can be added.

5. In `<YOUR_APPLICATION_NAME>/Gemfile` add the following gem: `gem 'ddtrace'` and run `bundle install`

6. From the root of your project directory, run `rails server -b 0.0.0.0` to start the server *without* binding it exclusively to the vm (`-b 0.0.0.0`), which rails will do by default. This will allow you to access it in the browser from your host machine.

7. In your browser, navigate to `http://127.0.0.1:5051` to see the homepage on your rails application.

8. Navigate to the traces page of the Datadog app to see traces appearing.
