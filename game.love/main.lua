local utf8 = require("utf8")
 
love.window.setMode( 500,500)
love.window.setTitle("Terminal Test")

function love.load()
    text = ""
    textup = ""
    cud = "~"
    love.keyboard.setKeyRepeat(true)
    status = "None"
end
 
function love.textinput(t)
    text = text .. t
end
 
function love.keypressed(key)
    if key == "backspace" then
        local byteoffset = utf8.offset(text, -1)
        if byteoffset then
            text = string.sub(text, 1, byteoffset - 1)
        end
    end

end
 
function love.update(dt)
	if love.keyboard.isDown( "escape" ) then
		love.event.quit()
	end
	if love.keyboard.isDown( "return" ) then
		if text == "Hello" then
			status = "Accepted"
			textup = text
			text = ""
			love.timer.sleep(0.25)
		elseif string.find(text,"apt" ) then
			status = "Command blocked"
			textup = text
			text = ""
			love.timer.sleep(0.25)
		elseif string.find(text, "cd", 1) then
			if text == "cd /" then
				cud = "/"
				status = "Directory changed."
				textup = text
				text = ""
				love.timer.sleep(0.25)
			elseif text == "cd ~" then
				cud = "~"
				status = "Directory changed."
				textup = text
				text = ""
				love.timer.sleep(0.25)
			elseif text == "cd /var/www/html" then
				status = "This isn't Apache."
				textup = text
				text = ""
				love.timer.sleep(0.25)
			else 
				status = "Directory error"
				textup = text
				text = ""
				love.timer.sleep(0.25)
			end
		else 
			status = "Command not recognised"
			textup = text
			text = ""
			love.timer.sleep(0.25)
		end

	end
	if love.keyboard.isDown( "up" ) then
		text = textup
	end
end


function love.draw()
	love.graphics.print("Current Directory: ", 10, 440)
	love.graphics.printf(cud, 130, 440, love.graphics.getWidth())
	love.graphics.print("Status: ", 10, 460)
	love.graphics.printf(status, 60, 460, love.graphics.getWidth())
    love.graphics.printf(text, 10, 480, love.graphics.getWidth())
end