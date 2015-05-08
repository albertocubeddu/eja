-- Copyright (C) 2007-2015 by Ubaldo Porcheddu <ubaldo@eja.it>

eja.help.webCns='cns timeout22'

function ejaWebCns(web)
    ejaFileAppend("/tmp/asd.asd",web.path)
    if web.path == "/library/test/success.html" or (web.headerIn['user-agent'] and web.headerIn['user-agent']:match('CaptiveNetworkSupport')) then
        local cnsData='<HTML><HEAD><TITLE>Success</TITLE></HEAD><BODY>Success</BODY></HTML>'
        if eja.opt.webCns then
            local cnsCheck=0
            local cnsPath=sf('%s/eja.cns.log',eja.pathTmp)
            local cnsLog=ejaFileRead(cnsPath) or ''
            
            for time,ip,url in cnsLog:gmatch('([^ ]-) ([^ ]-) ([^\n]-)\n') do
                if (ip==web.remoteIp or url==web.path) and os.time()-time<n(eja.opt.webCns) then cnsCheck=1 end
            end
            
            if cnsCheck>0 then
                web.data=cnsData
            else
                ejaFileAppend(cnsPath,os.time()..' '..web.remoteIp..' '..web.path.."\n")
                web.data='CNS'
            end
        else
            web.data=cnsData
        end
        
        web.cns=1
    end

    if web.path == "/generate_204" or web.path == "generate_204" then
        local cnsData='<HTML><HEAD><TITLE>Success</TITLE></HEAD><BODY>Success</BODY></HTML>'
        if eja.opt.webCns then
            local cnsCheck=0
            local cnsPath=sf('%s/eja.cns.log',eja.pathTmp)
            local cnsLog=ejaFileRead(cnsPath) or ''
            
            for time,ip,url in cnsLog:gmatch('([^ ]-) ([^ ]-) ([^\n]-)\n') do
                if (ip==web.remoteIp or url==web.path) and os.time()-time<n(eja.opt.webCns) then cnsCheck=1 end
            end
            
            if cnsCheck>0 then
                web.data=cnsData
            else
                ejaFileAppend(cnsPath,os.time()..' '..web.remoteIp..' '..web.path.."\n")
                web.data='EJA EJA EJA EJA EJA EJA EJA EJA EJA !!!!!!!'
            end
        else
            web.data=cnsData
        end
        web.cns=1
    end

    return web
end
