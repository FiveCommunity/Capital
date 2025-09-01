---------------------------------------------------------------------------------------------------------------------------------
-- BASE.LUA
---------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('gb_framework/createUser', 'insert into users (whitelist, banned) values (false, false)')
vRP.prepare('gb_framework/addIdentifier', 'insert into user_ids (identifier, user_id) values (@identifier, @user_id)')
vRP.prepare('gb_framework/getIdentifier', 'select user_id from user_ids where identifier = @identifier')

vRP.prepare('vRP/create_account', 'insert into users (steam) values (@steam)')
vRP.prepare('vRP/get_whitelist_identifiers', 'select id from user_ids where identifier = @identifier')
vRP.prepare('vRP/create_whitelist_identifiers', 'insert into user_ids (identifier, id) values (@identifier, @id)')
vRP.prepare('vRP/get_account_with_id', 'select * from users where id = @id')
vRP.prepare('vRP/get_account_with_steam', 'select * from users where steam = @id')

vRP.prepare('vRP/update_account_login', 'update users set ip = @ip where id = @id')
vRP.prepare('vRP/update_last_login', 'update user_characters set last_login = current_timestamp() where id = @id')

vRP.prepare("vRP/set_userdata", "REPLACE INTO user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata", "SELECT dvalue FROM user_data WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("vRP/rem_userdata", "DELETE FROM user_data WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("vRP/set_srvdata", "REPLACE INTO srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata", "SELECT dvalue FROM srv_data WHERE dkey = @key")
vRP.prepare("vRP/rem_srv_data", "DELETE FROM srv_data WHERE dkey = @dkey")
vRP.prepare("vRP/get_banned", "SELECT banned FROM users WHERE id = @user_id")
vRP.prepare("vRP/get_identifiers_by_userid", "SELECT identifier FROM user_ids WHERE user_id = @user_id")
vRP.prepare("vRP/set_banned", "UPDATE users SET banned = @banned WHERE id = @user_id")
vRP.prepare('gb_framework/getWhitelist', 'SELECT whitelist FROM users WHERE id = @user_id')
vRP.prepare('gb_framework/setWhitelist', 'UPDATE users SET whitelist = @whitelist WHERE id = @user_id')
vRP.prepare('gb_framework/setLogin', 'UPDATE users SET last_login = current_timestamp(), ip = @ip WHERE id = @user_id')
---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------
-- IDENTITY.LUA
---------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_user_identity","SELECT * FROM user_characters WHERE id = @user_id")
vRP.prepare("vRP/get_userbyreg","SELECT id FROM user_characters WHERE registration = @registration")
vRP.prepare("vRP/get_userbyphone","SELECT id FROM user_characters WHERE phone = @phone")
vRP.prepare("vRP/get_userbyplate","SELECT user_id FROM user_vehicles WHERE plate = @plate")
---------------------------------------------------------------------------------------------------------------------------------