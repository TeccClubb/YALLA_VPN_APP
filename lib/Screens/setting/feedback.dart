import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _selectedRating = 4; // Default to love emoji (5th emoji, index 4)
  String _selectedCategory = 'Other';
  final TextEditingController _feedbackController = TextEditingController();

  final List<String> _emojis = ['😡', '😕', '😐', '😊', '😍'];
  final List<String> _categories = [
    'App Design',
    'Speed',
    'Connection',
    'Bugs',
    'Other',
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button - Reduced padding
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18, // Reduced from 20
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Feedback',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.daysOne(
                        fontSize: 20, // Reduced from 22
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18), // Reduced from 20
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ), // Reduced from 20
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25), // Reduced from 40
                    // Chat Icon - Reduced size
                    Container(
                      width: 65, // Reduced from 80
                      height: 65, // Reduced from 80
                      decoration: BoxDecoration(
                        color: const Color(0xFF00417B),
                        borderRadius: BorderRadius.circular(32.5),
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 32, // Reduced from 40
                      ),
                    ),

                    const SizedBox(height: 20), // Reduced from 30
                    // Main Title - Reduced size
                    Text(
                      'We\'d love to hear your\nthoughts!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 20, // Reduced from 24
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 12), // Reduced from 16
                    // Subtitle - Reduced size
                    Text(
                      'Your feedback helps us improve and bring you the\nbest VPN experience.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 14, // Reduced from 16
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 35), // Reduced from 50
                    // Rating Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'How was your experience?',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 16, // Reduced from 18
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16), // Reduced from 20
                    // Emoji Rating - Reduced size
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        final bool isSelected = _selectedRating == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRating = index;
                            });
                          },
                          child: Container(
                            width: 50, // Reduced from 60
                            height: 50, // Reduced from 60
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF00417B)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(25),
                              border: isSelected
                                  ? null
                                  : Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                            ),
                            child: Center(
                              child: Text(
                                _emojis[index],
                                style: const TextStyle(
                                  fontSize: 22,
                                ), // Reduced from 28
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 30), // Reduced from 40
                    // Category Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'What would you like to share about?',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 16, // Reduced from 18
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12), // Reduced from 16
                    // Category Chips - Reduced size
                    Wrap(
                      spacing: 10, // Reduced from 12
                      runSpacing: 10, // Reduced from 12
                      children: _categories.map((category) {
                        final bool isSelected = _selectedCategory == category;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16, // Reduced from 20
                              vertical: 10, // Reduced from 12
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF00417B)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                20,
                              ), // Reduced from 25
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF00417B)
                                    : Colors.grey[300]!,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              category,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 12, // Reduced from 14
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 30), // Reduced from 40
                    // Text Input Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tell us more',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 16, // Reduced from 18
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12), // Reduced from 16
                    // Text Area - Reduced size
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Reduced from 12
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: TextField(
                        controller: _feedbackController,
                        maxLines: 5, // Reduced from 6
                        maxLength: 500,
                        decoration: InputDecoration(
                          hintText: 'Tell us what\'s on your mind...',
                          hintStyle: GoogleFonts.nunitoSans(
                            fontSize: 14, // Reduced from 16
                            color: Colors.grey[500],
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(
                            14,
                          ), // Reduced from 16
                          counterText: '${_feedbackController.text.length}/500',
                          counterStyle: GoogleFonts.nunitoSans(
                            fontSize: 10, // Reduced from 12
                            color: Colors.grey[500],
                          ),
                        ),
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14, // Reduced from 16
                          color: const Color(0xFF1F2937),
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                      ),
                    ),

                    const SizedBox(height: 16), // Reduced from 20
                    // Attach Screenshot - Reduced size
                    Row(
                      children: [
                        Icon(
                          Icons.attach_file,
                          size: 18, // Reduced from 20
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6), // Reduced from 8
                        Text(
                          'Attach screenshot (optional)',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14, // Reduced from 16
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30), // Reduced from 40
                    // Send Button - Reduced size
                    SizedBox(
                      width: double.infinity,
                      height: 48, // Reduced from 56
                      child: ElevatedButton(
                        onPressed: () {
                          _sendFeedback();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00417B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              24,
                            ), // Reduced from 28
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.send,
                              size: 18, // Reduced from 20
                            ),
                            const SizedBox(width: 6), // Reduced from 8
                            Text(
                              'Send Feedback',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 16, // Reduced from 18
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12), // Reduced from 16
                    // Response Time Text - Reduced size
                    Text(
                      'We usually respond within 24 hours.',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12, // Reduced from 14
                        color: Colors.grey[500],
                      ),
                    ),

                    const SizedBox(height: 20), // Reduced from 30
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendFeedback() {
    // Create feedback data
    final feedbackData = {
      'rating': _selectedRating + 1, // Convert to 1-5 scale
      'emoji': _emojis[_selectedRating],
      'category': _selectedCategory,
      'message': _feedbackController.text,
      'user': 'uzairahmadaio',
      'timestamp': '2025-10-07 12:06:23',
    };

    // Show success message
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 18,
            ), // Reduced from 20
            const SizedBox(width: 6), // Reduced from 8
            Text(
              'Feedback sent successfully! Thank you.',
              style: GoogleFonts.nunitoSans(
                fontSize: 12, // Reduced from 14
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );

    print('Feedback Data: $feedbackData'); // For debugging
  }
}
