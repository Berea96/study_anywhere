var express = require('express');
var bodyParser = require('body-parser');
var session = require('express-session');
var url = require('url');
var crypto = require('crypto');

var db_member = require('../models/db_member');
var router = express.Router();

router.use(session({
	 secret: 'study_anywhere',
	 resave: false,
	 saveUninitialized: true
	}));


router.post('/identify', function(req, res, next){
	console.log(req.body.mem_ID);
	console.log(req.body.mem_Hash);
	var javahash = (req.body.mem_Hash).toString();
	
	sess = req,session;
	sess.mem_ID = req.body.mem_ID;
	sess.mem_Hash = javahash;

	
	db_member.hash(req.body.mem_ID, function(data){
		
		var id = data.member_pw;
		var email = data.member_email;
		var toenc = (id+email).toString();
		
		console.log(id);
		console.log(email);
		console.log(toenc);
		
		var nodehash = crypto.createHash('sha256').update(toenc).digest("hex");
		console.log(nodehash);
		console.log(nodehash == javahash);
		
		if(nodehash == sess.mem_Hash){
			//res.render('index', { title: req.body.mem_ID });
			res.redirect('/');
			
		}else {
			res.writeHead(200, {'Content-Type':'text/html; charset=utf-8'});
			res.end('<script>alert("인증도중 오류가 발생하였습니다."); window.location="http://localhost/Study_Anywhere/";</script>')
		}
		
	});
	
});


router.get('/', function(req,res){
	res.render('lobby.ejs' , {"title": "lobby"});
})



module.exports = router;
