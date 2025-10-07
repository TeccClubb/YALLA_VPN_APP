import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServerScreen extends StatefulWidget {
  const ServerScreen({Key? key}) : super(key: key);

  @override
  State<ServerScreen> createState() => _ServerScreenState();
}

class _ServerScreenState extends State<ServerScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedServerIndex = 0; // Pakistan selected by default
  Set<int> _favoriteServers = {1}; // Turkey is favorited

  final List<ServerLocation> _allServers = [
    ServerLocation(
      id: 0,
      country: 'Pakistan',
      city: 'Islamabad',
      flagAsset: 'assets/pakistan_flag.png',
      ping: '25ms',
      signalStrength: 3,
      isPremium: false,
    ),
    ServerLocation(
      id: 1,
      country: 'Turkey',
      city: 'Istanbul',
      flagAsset: 'assets/turkey_flag.png',
      ping: '35ms',
      signalStrength: 4,
      isPremium: true,
    ),
    ServerLocation(
      id: 2,
      country: 'U.S.A',
      city: 'Washington',
      flagAsset: 'assets/usa_flag.png',
      ping: '50ms',
      signalStrength: 5,
      isPremium: false,
    ),
    ServerLocation(
      id: 3,
      country: 'Australia',
      city: 'Canberra',
      flagAsset: 'assets/australia_flag.png',
      ping: '35ms',
      signalStrength: 4,
      isPremium: false,
    ),
  ];

  // Get sorted servers with favorites on top
  List<ServerLocation> get _sortedServers {
    final favoriteServers = _allServers.where((server) => _favoriteServers.contains(server.id)).toList();
    final nonFavoriteServers = _allServers.where((server) => !_favoriteServers.contains(server.id)).toList();
    
    // Sort favorites by country name
    favoriteServers.sort((a, b) => a.country.compareTo(b.country));
    // Sort non-favorites by country name
    nonFavoriteServers.sort((a, b) => a.country.compareTo(b.country));
    
    return [...favoriteServers, ...nonFavoriteServers];
  }

  @override
  Widget build(BuildContext context) {
    final sortedServers = _sortedServers;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Server',
                    style: GoogleFonts.daysOne(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showFavoritesOnly();
                    },
                    child: Icon(
                      Icons.star_outline,
                      size: 24,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    color: const Color(0xFF374151),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search Locations or country...',
                    hintStyle: GoogleFonts.nunitoSans(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Quick Action Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Action',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Fastest Server Card - Clickable
                  GestureDetector(
                    onTap: () {
                      // Find the server with best ping and select it
                      final fastestServer = _allServers.reduce((a, b) {
                        final aPing = int.parse(a.ping.replaceAll('ms', ''));
                        final bPing = int.parse(b.ping.replaceAll('ms', ''));
                        return aPing < bPing ? a : b;
                      });
                      setState(() {
                        _selectedServerIndex = fastestServer.id;
                      });
                      _showServerSelectedMessage(fastestServer.country);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fastest Server',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1F2937),
                                  ),
                                ),
                                Text(
                                  'Connect to the fastest available server',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Random Location Card - Clickable
                  GestureDetector(
                    onTap: () {
                      // Select a random server
                      final randomServer = _allServers[DateTime.now().millisecond % _allServers.length];
                      setState(() {
                        _selectedServerIndex = randomServer.id;
                      });
                      _showServerSelectedMessage(randomServer.country);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00417B),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.casino,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Random Location',
                                        style: GoogleFonts.nunitoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF1F2937),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text('👑', style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                Text(
                                  'Connect to the fastest server location',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // All Location Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'All Location',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text('👑', style: TextStyle(fontSize: 16)),
                        const Spacer(),
                        Text(
                          '${_favoriteServers.length} favorites',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Server List
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: sortedServers.length,
                      itemBuilder: (context, index) {
                        return _buildServerItem(sortedServers[index], index == 0 && _favoriteServers.isNotEmpty);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServerItem(ServerLocation server, bool showFavoriteHeader) {
    final isSelected = _selectedServerIndex == server.id;
    final isFavorite = _favoriteServers.contains(server.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show "Favorites" header for first favorite item
        if (showFavoriteHeader) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  'Favorites',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber[700],
                  ),
                ),
              ],
            ),
          ),
        ],
        
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedServerIndex = server.id;
            });
            _showServerSelectedMessage(server.country);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE8F2FF) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: isSelected 
                ? Border.all(color: const Color(0xFF00417B).withOpacity(0.3), width: 1)
                : isFavorite 
                  ? Border.all(color: Colors.amber.withOpacity(0.3), width: 1)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Flag
                  Container(
                    width: 40,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        server.flagAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF00417B),
                            child: const Icon(
                              Icons.flag,
                              color: Colors.white,
                              size: 16,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Country and City info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                server.country,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1F2937),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            // Signal Strength
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (i) {
                                return Container(
                                  width: 2,
                                  height: 6 + (i * 1.5),
                                  margin: const EdgeInsets.only(right: 0.8),
                                  decoration: BoxDecoration(
                                    color: i < server.signalStrength 
                                      ? Colors.green 
                                      : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              server.ping,
                              style: GoogleFonts.nunitoSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          server.city,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Favorite Star
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isFavorite) {
                          _favoriteServers.remove(server.id);
                          _showServerUnfavoritedMessage(server.country);
                        } else {
                          _favoriteServers.add(server.id);
                          _showServerFavoritedMessage(server.country);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        isFavorite ? Icons.star : Icons.star_outline,
                        color: isFavorite ? Colors.amber : Colors.grey[400],
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Show only favorites when star in header is tapped
  void _showFavoritesOnly() {
    if (_favoriteServers.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Favorite Servers',
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _favoriteServers.map((id) {
              final server = _allServers.firstWhere((s) => s.id == id);
              return ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text(server.country),
                subtitle: Text(server.city),
                onTap: () {
                  setState(() {
                    _selectedServerIndex = server.id;
                  });
                  Navigator.pop(context);
                  _showServerSelectedMessage(server.country);
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        ),
      );
    } else {
      _showServerSelectedMessage('No favorite servers yet');
    }
  }

  // Helper methods for user feedback
  void _showServerSelectedMessage(String serverName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Selected: $serverName',
          style: GoogleFonts.nunitoSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF00417B),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showServerFavoritedMessage(String serverName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 8),
            Text(
              '$serverName added to favorites',
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.amber[700],
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showServerUnfavoritedMessage(String serverName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.star_outline, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              '$serverName removed from favorites',
              style: GoogleFonts.nunitoSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[600],
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class ServerLocation {
  final int id;
  final String country;
  final String city;
  final String flagAsset;
  final String ping;
  final int signalStrength; // 1-5
  final bool isPremium;

  ServerLocation({
    required this.id,
    required this.country,
    required this.city,
    required this.flagAsset,
    required this.ping,
    required this.signalStrength,
    required this.isPremium,
  });
}