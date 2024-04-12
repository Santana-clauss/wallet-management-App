import 'dart:convert';

class _ProfilePageState extends State<ProfilePage> {
  late String userName;
  late String email;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final response = await http.get(Uri.parse('YOUR_BACKEND_ENDPOINT_HERE'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        userName = data['name'];
        email = data['email'];
      });
    } else {
      throw Exception('Failed to load user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Your UI code with userName and email variables
  }
}
