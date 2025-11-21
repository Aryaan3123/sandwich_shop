# 🥪 Sandwich Shop Flutter App

A modern, interactive Flutter application for ordering custom sandwiches. Built with clean architecture principles, comprehensive testing, and a focus on user experience.

## 📱 Features

### Core Functionality
- **Interactive Sandwich Counter**: Add/remove sandwiches with smart button states
- **Customizable Orders**: Choose bread type (White, Wheat, Wholemeal) 
- **Size Selection**: Toggle between 6-inch and Footlong sandwiches
- **Real-time Pricing**: Live price calculation (£7 for 6-inch, £11 for footlong)
- **Order Notes**: Add special instructions for your sandwich
- **Real-time Display**: Live preview of your order with sandwich emojis 🥪

### Technical Features
- **Repository Pattern**: Clean separation of business logic and UI
- **Price Management**: Dedicated PricingRepository for cost calculations
- **State Management**: Efficient state handling with proper validation
- **Automatic Button States**: Add/Remove buttons automatically disable when limits are reached
- **Input Validation**: Smart quantity limits and user feedback
- **Responsive Design**: Clean, modern Material Design interface

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your system:

1. **Flutter SDK** (>=2.17.0)
   - **macOS**: `brew install --cask flutter`
   - **Windows**: `choco install flutter`
   - Verify with: `flutter doctor`

2. **Git**
   - Verify with: `git --version`
   - Download from [Git's official site](https://git-scm.com/downloads) if missing

3. **Visual Studio Code** (recommended)
   - **macOS**: `brew install --cask visual-studio-code`
   - **Windows**: `choco install vscode`
   - Install Flutter and Dart extensions

4. **Chrome** (for web development)

### Installation

#### First Time Setup
```bash
# Clone the repository
git clone https://github.com/Aryaan3123/sandwich_shop.git
cd sandwich_shop

# Get dependencies
flutter pub get

# Run the app
flutter run
```

#### Existing Project
```bash
# Navigate to project directory
cd sandwich_shop

# Pull latest changes
git pull origin main

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## 🎯 How to Use

### Basic Operations

1. **Start the App**
   ```bash
   flutter run
   ```
   Select your target device (Chrome for web development)

2. **Place an Order**
   - Use **Add** button to increase sandwich quantity (max 5)
   - Use **Remove** button to decrease quantity (min 0)  
   - Toggle switch to choose **6-inch** or **Footlong**
   - Select bread type from dropdown menu
   - Add special notes in the text field
   - **View real-time price updates** as you customize your order

3. **View Your Order**
   - See real-time order summary with sandwich count and emojis
   - **Live price display** showing total cost in green
   - Notes display shows "No notes added." when empty
   - Buttons automatically disable at quantity limits

### Advanced Features

#### Pricing System
- **6-inch sandwiches**: £7.00 each
- **Footlong sandwiches**: £11.00 each  
- **Real-time calculation**: Price updates instantly when you change quantity or size
- **Professional formatting**: Currency display with proper decimal places

#### Custom Bread Types
- **White** (default)
- **Wheat** 
- **Wholemeal**

#### Order Notes
Add special instructions like:
- "Extra cheese, no onions"
- "Toasted bread please"
- "Light mayo"

## 🧪 Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test Files
```bash
# Widget tests
flutter test test/widget_test.dart

# Repository tests  
flutter test test/repositories/
```

### Test Coverage
The app includes comprehensive testing:

- **Unit Tests**: Repository pattern business logic
- **Widget Tests**: UI components and interactions  
- **Integration Tests**: End-to-end user flows

### Test Examples
```dart
// Test button states
testWidgets('Add button disables at max quantity', (tester) async {
  // Test implementation
});

// Test repository logic
test('quantity should not exceed maxQuantity', () {
  // Test implementation
});
```

## 🏗️ Architecture

### Project Structure
```
lib/
├── main.dart                     # App entry point & main UI
├── repositories/
│   ├── order_repository.dart     # Business logic for orders
│   └── pricing_repository.dart   # Price calculation logic
└── views/
    └── app_styles.dart          # UI styling constants

test/
├── widget_test.dart             # UI component tests
└── repositories/
    └── order_repository_test.dart # Business logic tests
```

### Design Patterns

#### Repository Pattern
- **OrderRepository**: Manages quantity state and business rules
- **PricingRepository**: Handles all price calculations and constants
- **Separation of Concerns**: UI components stay focused on presentation
- **Testability**: Business logic can be tested independently

#### State Management  
- **StatefulWidget**: For components with changing state
- **TextEditingController**: For form input management
- **setState()**: For triggering UI rebuilds

### Key Components

#### OrderRepository
```dart
class OrderRepository {
  int get quantity;              // Current quantity
  bool get canIncrement;         // Can add more?
  bool get canDecrement;         // Can remove items?
  void increment();              // Add sandwich
  void decrement();              // Remove sandwich
}
```

#### PricingRepository
```dart
class PricingRepository {
  static const double sixInchPrice = 7.0;   // £7 for 6-inch
  static const double footlongPrice = 11.0; // £11 for footlong
  
  double calculateTotalPrice(int quantity, bool isFootlong) {
    return (isFootlong ? footlongPrice : sixInchPrice) * quantity;
  }
}
```

#### OrderItemDisplay Widget
```dart
OrderItemDisplay(
  quantity: _orderRepository.quantity,
  itemType: sandwichType,
  breadType: _selectedBreadType,
  orderNote: noteForDisplay,
)
```

## 🛠️ Development

### Adding New Features

1. **New Sandwich Types**
   - Add to `BreadType` enum in `main.dart`
   - Update dropdown menu entries
   - Add corresponding tests

2. **New Business Logic**
   - Extend `OrderRepository` or `PricingRepository` classes
   - Add unit tests for new functionality
   - Update UI components as needed

3. **Pricing Changes**
   - Modify constants in `PricingRepository`
   - Update tests to reflect new prices
   - Consider adding price configuration options

### Code Style
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable names
- Add comments for complex business logic
- Maintain test coverage for new features

### Git Workflow
```bash
# Create feature branch
git checkout -b feature/new-sandwich-type

# Make changes and commit
git add .
git commit -m "Add new sandwich type option"

# Push and create pull request
git push origin feature/new-sandwich-type
```

## 🐛 Troubleshooting

### Common Issues

#### Flutter Doctor Issues
```bash
flutter doctor
# Follow the suggestions to fix any issues
```

#### Build Errors
```bash
# Clean build cache
flutter clean
flutter pub get

# Try running again
flutter run
```

#### Test Failures
```bash
# Run tests in verbose mode
flutter test --reporter=expanded

# Check specific test file
flutter test test/widget_test.dart -v
```

### Platform Specific

#### Windows
- Ensure Windows Developer Mode is enabled
- Check antivirus isn't blocking Flutter

#### macOS  
- Ensure Xcode command line tools are installed
- Check iOS Simulator is available

#### Web
- Ensure Chrome is installed and accessible
- Check no proxy/firewall issues

## 📚 Learning Resources

### Flutter Documentation
- [Flutter.dev](https://flutter.dev) - Official documentation
- [Dart.dev](https://dart.dev) - Dart language guide
- [Material Design](https://material.io/design) - Design system

### Tutorials Used in This Project
- **StatefulWidget**: Managing changing state in UI
- **Repository Pattern**: Separating business logic  
- **Form Input**: Handling user text input
- **Testing**: Unit and widget test strategies
- **Price Calculation**: Real-time cost computation

### Next Steps
- Explore state management with Provider/Riverpod
- Add data persistence with local storage
- Implement navigation between multiple screens
- Add animations and transitions
- Extend pricing with discounts and promotions

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is part of a Flutter learning course and is for educational purposes.

## 📞 Support

- **Discord**: [Course Discord Channel](https://discord.com/channels/760155974467059762/1370633732779933806)
- **Issues**: Create a GitHub issue for bugs or feature requests
- **Documentation**: Check Flutter docs for framework questions

---

**Built with ❤️ using Flutter & Dart**
