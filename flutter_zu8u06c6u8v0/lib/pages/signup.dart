import 'package:flutter/material.dart';
import 'package:flutter_app/pages/feed.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String? _username, _email, _password, _confirmPassword;
  String? _selectedDay, _selectedMonth, _selectedYear;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // Dropdown values for day, month (numbers), and year
  final List<String> _days = List.generate(31, (index) => (index + 1).toString());
  final List<String> _months = List.generate(12, (index) => (index + 1).toString());
  final List<String> _years = List.generate(100, (index) => (DateTime.now().year - index).toString());

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Material(
        child: Container(
          color: Color(0xFFEEECF6),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Sign ',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Up',
                                  style: TextStyle(
                                    color: Color(0xFF2810BF),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildTextField(
                          label: 'Username',
                          onSaved: (value) => _username = value,
                        ),
                        SizedBox(height: 10),
                        _buildTextField(
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) => _email = value,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdownField(
                                label: 'Day',
                                items: _days,
                                value: _selectedDay,
                                onChanged: (value) => setState(() {
                                  _selectedDay = value;
                                }),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildDropdownField(
                                label: 'Month',
                                items: _months,
                                value: _selectedMonth,
                                onChanged: (value) => setState(() {
                                  _selectedMonth = value;
                                }),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildDropdownField(
                                label: 'Year',
                                items: _years,
                                value: _selectedYear,
                                onChanged: (value) => setState(() {
                                  _selectedYear = value;
                                }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _buildPasswordField(
                          label: 'Password',
                          onSaved: (value) => _password = value,
                        ),
                        SizedBox(height: 10),
                        _buildPasswordField(
                          label: 'Confirm Password',
                          onSaved: (value) => _confirmPassword = value,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 18),
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFFF5F5F5),
                                  fontSize: 18,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Color(0xFF1D1D1D),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print('Login tapped!');
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFF563FE8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, TextInputType? keyboardType, required FormFieldSetter<String> onSaved}) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA99BFF)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2810BF)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }

  Widget _buildDropdownField({required String label, required List<String> items, String? value, required ValueChanged<String?> onChanged}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA99BFF)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF2810BF)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select your $label';
        }
        return null;
      },
    );
  }

void _submitForm() {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    print(_password);
    print(_confirmPassword);

    if (_password != _confirmPassword) {
      print("Passwords do not match!");
    } else {
      // Navigate to FeedPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => FeedPage()),
      );
    }
  }
}

Widget _buildPasswordField({required String label, required FormFieldSetter<String> onSaved}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      suffixIcon: IconButton(
        icon: Icon(
          label == 'Password' ? _isPasswordVisible ? Icons.visibility : Icons.visibility_off : _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            if (label == 'Password') {
              _isPasswordVisible = !_isPasswordVisible;
            } else {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            }
          });
        },
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFA99BFF)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF2810BF)),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    obscureText: label == 'Password' ? !_isPasswordVisible : !_isConfirmPasswordVisible,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your $label';
      } else if (label == 'Confirm Password' && _password != _password) {
        return 'Passwords do not match';
      } else if (label == 'Password' && value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
      return null;
    },
    onSaved: onSaved,
  );
}

 
}
