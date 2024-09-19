<?php
// ** Datenbankeinstellungen - Diese Informationen bekommst du von deinem Hostinganbieter ** //
define('DB_NAME', 'db'); // Hier wird der Name der Datenbank eingefügt
define('DB_USER', 'user'); // Hier wird der Datenbankbenutzer eingefügt
define('DB_PASSWORD', 'pwd'); // Hier wird das Datenbankpasswort eingefügt
define('DB_HOST', 'mariadb'); // Der Hostname, normalerweise 'localhost' oder der Name des MariaDB-Containers

// ** Datenbankzeichensatz für die Datenbanktabelle ** //
define('DB_CHARSET', 'utf8mb4');

// ** Der Collation für die Datenbank ** //
define('DB_COLLATE', '');

// ** Authentifizierungsschlüssel und Salze ** //
// Ändere diese zu zufälligen einzigartigen Werten, kannst sie durch den WordPress Secret Key Generator ersetzen
define('AUTH_KEY',         '1rUfiA@P1A6L95Z6+P1dh%oc=2`6-1Lg8L*J0A!fJpI$sDhU0%;tD~)Wyt-f&2G');
define('SECURE_AUTH_KEY',  'd!1~E-?G8fKkQ1^tA!k+XA2J-`aV#F]b}4~F5v&u1kdN@#~YJp.}YgihF4xT:Ra');
define('LOGGED_IN_KEY',    '5Dq7XM3aP!N>g-)9Hh2|qH3k#|`Vf?+oQ@yO*6-6b(A;8Sy9-yD`?l-R^qE/a+mQ');
define('NONCE_KEY',        'p*Jq$6i^@Rgj&4@dG_`Z>|0lz}$m5Q+0T*97Fz2wU;z$P0RO3k,UdKzM9.Rp,Z1X');
define('AUTH_SALT',        'qG?W}$J+t|B+9g!bP<BGf5p-5~mfT&!7-q7=C0O%u,n61B:s8z8##rpM|9!Z+(p');
define('SECURE_AUTH_SALT', 'K&Tk6J!MWO&!-?8_UZLg6s:bO5A%tI|RCp-vqf(XEL5>S$O)m]7Q|~g6_v1%_L!r');
define('LOGGED_IN_SALT',   'k%/Uq@P<7b(_cLGtN8Pq3`xHLS[57=y.]=|7r);M[?]w_>RpU~z4ZQUl3YZUq?J7');
define('NONCE_SALT',       'Q#1|-y-G`v-5!Q/G9m%.g&Jv(2l]:s!XpF_*~A9pV2`D2;4/UJzRkR>u[TA/Vz@w');

// ** WordPress-Datenbanktabellen-Präfix ** //
$table_prefix = 'wp_'; // Nur Zahlen, Buchstaben und Unterstriche bitte!

// ** Debugging-Modus ** //
define('WP_DEBUG', false);

// ** Absolute Pfade zum WordPress-Verzeichnis ** //
if ( ! defined('ABSPATH') ) {
	define('ABSPATH', __DIR__ . '/');
}

// ** Set up WordPress vars and included files ** //
require_once ABSPATH . 'wp-settings.php';
?>
