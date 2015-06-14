Pony.options = {
  :to => 'abi@abisinging.co.uk',
  :via => :smtp,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'darren.daraz@gmail.com',
    :password             => 'vnrnsmoniwbvvwhx',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
  }
}