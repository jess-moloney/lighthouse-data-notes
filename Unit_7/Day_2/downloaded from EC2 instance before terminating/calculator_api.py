# import Flask and jsonify
from flask import Flask, jsonify, request

# import Resource, Api and reqparser
from flask_restful import Resource, Api, reqparse

# Create an application:
app = Flask(__name__)

# Create an API from the application:
api = Api(app)

class Add(Resource):
    def post(self):
        json_data = request.get_json()
        num1 = json_data["num1"]
        num2 = json_data["num2"]
        return num1+num2    

class Subtract(Resource):
    def post(self):
        json_data = request.get_json()
        num1 = json_data["num1"]
        num2 = json_data["num2"]
        return num1-num2

class Multiply(Resource):
    def post(self):
        json_data = request.get_json()
        num1 = json_data["num1"]
        num2 = json_data["num2"]
        return num1*num2

class Divide(Resource):
    def post(self):
        json_data = request.get_json()
        num1 = json_data["num1"]
        num2 = json_data["num2"]
        return num1/num2

# assign endpoints
api.add_resource(Add, '/add',)
api.add_resource(Subtract, '/subtract',)
api.add_resource(Multiply, '/multiply',)
api.add_resource(Divide, '/divide',)

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5550)


