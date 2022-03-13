# === A&R.local rake tasks

namespace :arlocal do

  require 'io/console'


  namespace :administrator do
    desc 'Authorize an administrator to make changes'
    task :auth => :environment do
      administrator_list
      administrator_authorize
    end

    desc 'Create an administrator'
    task :create => :environment do
      administrator_create_from_input
    end

    desc 'Deauthorize an administrator from making changes'
    task :deauth => :environment do
      administrator_list
      administrator_deauthorize
    end

    desc 'Delete an administrator'
    task :delete => :environment do
      administrator_list
      administrator_delete
    end

    desc 'List administrators and whether they are authorized to make changes'
    task :list => :environment do
      administrator_list
    end
  end


  namespace :init do
    desc 'Inititalize A&R.local'
    task :all => :environment do
      puts "\n"
      puts '# A&R.local'
      puts "\n"
      puts '## Initializing'
      puts "\n"
      puts 'Any prompts left blank may be filled in later by running `rails arlocal:init:all` again,'
      puts 'or by running one of the individual initialization tasks (see `rails arlocal:init:tasks`).'
      puts "\n"
      [ 'db:schema:load',
        'arlocal:init:settings',
        'arlocal:administrator:create'
      ].each do |task|
        task_announcement(task)
        Rake::Task[task].invoke
      end
      puts "\n\n"
      puts '# Done with initialization tasks.'
      puts "\n"
    end

    desc 'Initialize arlocal settings'
    task :settings => :environment do
      arlocal_settings_initialize
    end

    desc 'List tasks performed in arlocal:init:all'
    task :tasks do
      puts "\n"
      puts '## Initialization tasks used by `rails arlocal:init:all`'
      puts "\n"
      puts '  - db:schema:load'
      puts '  - arlocal:init:settings'
      puts '  - arlocal:administrator:create'
      puts "\n"
    end
  end

end




# === Support methods for rake tasks

private


def administrator_authorize(id: nil)
  if id == nil
    id = prompt_for_text(message: 'Authorize administrator to make changes (id number)')
  end
  administrator = Administrator.find(id)
  administrator.has_authority_to_write = true
  administrator.save
  puts 'Administrator authorized.'
end


def administrator_deauthorize(id: nil)
  if id == nil
    id = prompt_for_text(message: 'Deauthorize administrator from making changes (id number)')
  end
  administrator = Administrator.find(id)
  administrator.has_authority_to_write = false
  administrator.save
  puts 'Administrator deauthorized.'
end


def administrator_create_from_input
  puts 'Creating an administrative user.'
  puts 'Leave {name} blank to cancel/skip.'
  name = prompt_for_text(message: 'Name')
  if name
    email = prompt_for_text(message: 'Email address (used for login)')
    has_auth = prompt_for_yes_no(default: :yes, message: 'Has authority to make changes?')
    password = prompt_for_password(message: 'Password')
    password_confirm = prompt_for_password(message: 'Confirm password')
    case password == password_confirm
    when true
      a = Administrator.create({ name: name, email: email, has_authority_to_write: has_auth, password: password })
      if a.save
        puts 'Administrative user has been created.'
      else
        puts 'Administrative user could not be created-- check console for messages.'
      end
    when false
      puts 'Administrative user could not be created-- password confirmation did not match.'
    end
  end
end


def administrator_delete
  id = prompt_for_text(message: 'Delete administrator (id number)')
  administrator = Administrator.find(id)
  if prompt_for_yes_no(default: :no, message: "Deleting admin user #{administrator.id}, #{administrator.email}.\n" + 'This cannot be undone. Are you sure?')
    au.delete
    puts 'Administrator deleted.'
  else
    puts 'Cancelled Administrator delete, no changes made.'
  end
end


def administrator_list
  puts 'Current administrator list'
  puts ' id  write_auth  email'
  Administrator.all.each.map do |administrator|
    puts "#{administrator.id.to_s.rjust(3)}  #{('true' if administrator.has_authority_to_write).to_s.rjust(10)}  #{administrator.email}"
  end
end


def arlocal_settings_initialize
  if ArlocalSettings.table_exists?
    arls = QueryArlocalSettings.get
    if arls == nil
      arls = ArlocalSettingsBuilder.new.build_and_save_default
    end

    # TODO: figure out why/when prompt_for_text returns `true`, therefore causing artist_name= assignment to fail
    arls.artist_name = prompt_for_text(message: 'Artist name')

    arls.artist_content_copyright_year_earliest = prompt_for_text(message: 'Earliest copyright year')
    arls.artist_content_copyright_year_latest = prompt_for_text(message: 'Latest copyright year (blank for year-of-moment)')
    arls.save
  else
    puts '*** ARLOCAL: Database entry for ArlocalSettings cannot be created. Has the database been initialized? ***'
    puts "\n"
  end
end


def task_announcement(task, depth: 3)
  puts "#{'#' * depth} #{task}"
  puts "\n"
end






# === User prompt/input methods


def prompt_for_password(message: nil)
  prompt_for_text(echo: :off, message: message)
end


def prompt_for_text(default: nil, echo: :on, message: nil)
  prompt = "#{message}"
  prompt << " [#{default}]" if default
  prompt << ": "
  STDOUT.print prompt
  case echo
  when :off
    text = STDIN.noecho(&:gets).chomp.strip
    STDOUT.print "\n"
  else
    text = STDIN.gets("\n").chomp.strip
  end
  if text == ''
    return_value = default
  else
    return_value = text
  end
  return_value
end


def prompt_for_yes_no(default: :no, message: nil)
  case default
  when :yes, true
    prompt = '[Y/n]: '
  when :no, false
    prompt = '[y/N]: '
  end
  STDOUT.print "#{message} #{prompt}"
  reply = STDIN.gets("\n").chomp.strip
  case reply[0].to_s.downcase
  when 'y'
    return_value = true
  when 'n'
    return_value = false
  else
    return_value = default
  end
  return_value
end
