<?php

$CONF['configured'] = true;
// correspond to dovecot maildir path /home/vmail/%d/%u 
$CONF['domain_path'] = 'YES';
$CONF['domain_in_mailbox'] = 'NO';
$CONF['transport_options'] = array (
    'virtual',  // for virtual accounts
    'local',    // for system accounts
    'relay'     // for backup mx
);

$CONF['database_type'] = 'pgsql';
$CONF['database_host'] = 'postgres';
$CONF['database_user'] = getenv('POSTFIXADMIN_DB_USER');
$CONF['database_password'] = getenv('POSTFIXADMIN_DB_PASSWORD');
$CONF['database_name'] = getenv('POSTFIXADMIN_DB_NAME');

$CONF['smtp_server'] = 'postfix';
$CONF['setup_password'] = getenv('POSTFIXADMIN_SETUP_PASSWORD');
$CONF['default_aliases'] = array(
    'postmaster' => 'postmaster@' . getenv('HOSTNAME'),
    'abuse' => 'postmaster@' . getenv('HOSTNAME')
);

$CONF['vacation_domain'] = 'autoreply.' . getenv('HOSTNAME');
$CONF['footer_text'] = 'Return to ' . getenv('HOSTNAME');
$CONF['footer_link'] = 'http://' . getenv('HOSTNAME');
