"""
    Sample Controller File

    A Controller should be in charge of responding to a request.
    Load models to interact with the database and load views to render them to the client.

    Create a controller using this template
"""
from system.core.controller import *

class Welcome(Controller):
    def __init__(self, action):
        super(Welcome, self).__init__(action)
        """
            This is an example of loading a model.
            Every controller has access to the load_model method.
        """
        self.load_model('Welcome')
        self.db = self._app.db

        """
        
        This is an example of a controller method that will load a view for the client 

        """
   
    def index(self):
        """
        A loaded model is accessible through the models attribute 
        self.models['WelcomeModel'].get_users()
        
        self.models['WelcomeModel'].add_message()
        # messages = self.models['WelcomeModel'].grab_messages()
        # user = self.models['WelcomeModel'].get_user()
        # to pass information on to a view it's the same as it was with Flask
        
        # return self.load_view('index.html', messages=messages, user=user)
        """
        return self.load_view('index.html')
    def signin(self):
        print ' ------ controller --------- signin ---------'
        return self.load_view('login.html')

    def register(self):
        print ' ------ controller --------- Register ---------'
        return self.load_view('register.html')

    def login(self):
        print ' ------ controller --------- Loing ---------'
        info = {
            'email': request.form['email'].lower(),
            'password': request.form['password']
        }
        
        user = self.models['Welcome'].user_login(info)
        if user['status']:
            print '----------------------------------------------'
            print user['personal']
            session['id'] = user['personal']['id']
            session['level'] = user['personal']['level']
            return redirect('/dashboard')
        else:
            return self.load_view('login.html', errors = user['errors'])    

    def sendregister(self):
        print ' ------ controller ---------  sendregister ---------'
        info = {
                'first_name': request.form['first_name'],
                'last_name': request.form['last_name'],
                'email': request.form['email'].lower(),
                'password': request.form['password'],
                'confirm_password':request.form['confirm_password']    
        }
        user = self.models['Welcome'].add_user(info)

        if user['status'] is False:
            #print user
            #print user['status']
            return self.load_view('register.html', errors = user['errors'])
        else:
            #print user
            session['id'] = user['personal'][0]['id']
            session['level'] = user['personal'][0]['level']
            print session['id']
            print session['level']
            return redirect('/dashboard')

    def dashboard(self):
        print ' ------ controller --------- Dashboard ---------'
        users = self.models['Welcome'].all_users()    
        return self.load_view('dashboard.html', users = users)
    def edit(self, user_id):
        print ' ------ controller --------- Edit  ---------'
        user = self.models['Welcome'].select_user(user_id)    
        return self.load_view('edit.html', user= user[0])

    def changeinfo(self, user_id):       
        print ' ------ controller --------- changeinfo  ---------'   
        print user_id 
        info = {
            'email' : request.form['email'],
            'first_name' : request.form['first_name'],
            'last_name' : request.form['last_name']
        }
        self.models['Welcome'].change_info(info, user_id)
        return redirect('/dashboard')

    def changepassword(self, user_id):       
        print ' ------ controller --------- changepassword  ---------'    
        print user_id
        info = {
            'password' : request.form['password'],
            'confirm_password' : request.form['confirm_password']
        }
        user = self.models['Welcome'].change_pw(info, user_id)
        if not user['status']:
            return self.load_view('edit.html', errors = user['errors'])
        else:     
            return redirect('/testapp')

    def testapp(self, user_id):
        print ' ------ controller --------- testapp  ---------'
        user = self.models['Welcome'].select_user(user_id)
        posts = self.models['Welcome'].all_posts()
        comments = self.models['Welcome'].all_comments()
        return self.load_view('testapp.html', user= user[0], posts = posts, comments = comments)
    def logout(self):
        session.clear()
        return redirect('/')

    def post(self, user_id):
        print  '------ controller --------- post  ---------'
        print session['id']
        info={'post': request.form['post'], 'wall_id':user_id ,'user_id': session['id'] }
        self.models['Welcome'].add_post(info)
        return redirect('/dashboard')

    def comment(self, post_id):
        print post_id
        info = { 
                'comment':request.form['comment'], 
                'user_id': session['id'],
                'post_id': post_id
            }
        self.models['Welcome'].add_comment(info)
        return redirect('/dashboard')   