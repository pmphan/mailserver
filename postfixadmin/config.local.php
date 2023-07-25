<?php

$CONF['configured'] = true;
// correspond to dovecot maildir path /home/vmail/%d/%u 
$CONF['domain_path'] = 'YES';
$CONF['domain_in_mailbox'] = 'NO';

$CONF['database_type'] = 'pgsql';
$CONF['database_host'] = 'postgres';
$CONF['database_user'] = getenv('POSTFIXADMIN_DB_USER');
$CONF['database_password'] = getenv('POSTFIXADMIN_DB_PASSWORD');
$CONF['database_name'] = getenv('POSTFIXADMIN_DB_NAME');

$CONF['smtp_server'] = 'postfix';
$CONF['admin_email'] = 'admin@' . getenv('HOSTNAME');
$CONF['setup_password'] = getenv('POSTFIXADMIN_SETUP_PASSWORD');

$CONF['page_size'] = '25';
$CONF['maxquota'] = '8192';
$CONF['default_aliases'] = array (
	'abuse' => 'abuse@' . getenv('HOSTNAME'),
	'hostmaster' => 'hostmaster@' . getenv('HOSTNAME'),
	'postmaster' => 'postmaster@' . getenv('HOSTNAME'),
	'webmaster' => 'webmaster@' . getenv('HOSTNAME')
);
$CONF['used_quotas'] = 'YES';
$CONF['quota'] = 'YES';
$CONF['new_quota_table'] = 'YES';
$CONF['vacation_domain'] = 'autoreply.' . getenv('HOSTNAME');
$CONF['footer_text'] = 'Return to ' . getenv('HOSTNAME') . '.tld';
$CONF['footer_link'] = 'http://' . getenv('HOSTNAME');
