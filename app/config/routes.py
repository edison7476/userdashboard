"""
    Routes Configuration File

    Put Routing rules here
"""
from system.core.router import routes

routes['default_controller'] = 'Welcome'
routes['/signin'] = 'Welcome#signin'
routes['/register'] = 'Welcome#register'
routes['POST']['/login']='Welcome#login'
routes['POST']['/sendregister'] = 'Welcome#sendregister'
routes['/dashboard'] = 'Welcome#dashboard'
routes['/edit/<user_id>'] = 'Welcome#edit'
routes['POST']['/changeinfo/<user_id>'] = 'Welcome#changeinfo'
routes['POST']['/changepassword/<user_id>'] = 'Welcome#changepassword'
routes['/testapp/<user_id>'] = 'Welcome#testapp'
routes['/logout'] = 'Welcome#logout'
routes['POST']['/post/<user_id>'] = 'Welcome#post'
routes['POST']['/comments/<post_id>'] = 'Welcome#comment'