/**
 * ReCyclo Realistic Mock Data
 * Rich datasets for realistic, production-feeling user experience
 */

const MockData = {
  currentUser: {
    name: 'Alex Rivers',
    email: 'alex.rivers@recyclo.eco',
    phone: '+91 98765 43210',
    location: '402 Oakwood Heights, Green Glen Layout, Bengaluru',
    avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
    stats: {
      totalRecycledKg: 54.2,
      collectionsCompleted: 14,
      moneyEarned: '₹975.00',
      co2SavedKg: 81.3
    },
    savedAddresses: [
      { id: 'addr-1', label: 'Home', address: '402 Oakwood Heights, Green Glen Layout, Bengaluru', isDefault: true },
      { id: 'addr-2', label: 'Office', address: 'EcoTech Hub, 3rd Floor, Outer Ring Road, Bengaluru', isDefault: false }
    ]
  },

  categories: [
    {
      id: 'plastic',
      name: 'Plastic',
      icon: 'plastic',
      desc: 'Bottles, containers, wrap, HDPE/PET',
      avgRate: '₹16 - ₹22 / kg',
      rateValue: 18,
      suggestedItems: ['Water bottles', 'Milk pouches', 'Takeout containers']
    },
    {
      id: 'paper',
      name: 'Paper',
      icon: 'paper',
      desc: 'Newspapers, cardboard boxes, books',
      avgRate: '₹12 - ₹15 / kg',
      rateValue: 14,
      suggestedItems: ['Cardboard boxes', 'Daily newspapers', 'Office paper']
    },
    {
      id: 'metal',
      name: 'Metal',
      icon: 'metal',
      desc: 'Aluminum cans, iron scrap, brass',
      avgRate: '₹30 - ₹45 / kg',
      rateValue: 35,
      suggestedItems: ['Beverage cans', 'Old utensils', 'Wire scraps']
    },
    {
      id: 'glass',
      name: 'Glass / Bottles',
      icon: 'glass',
      desc: 'Bottles, jars, unbroken glassware',
      avgRate: '₹4 - ₹8 / kg',
      rateValue: 6,
      suggestedItems: ['Beer bottles', 'Jam jars', 'Beverage glass']
    },
    {
      id: 'clothes',
      name: 'Old Clothes',
      icon: 'clothes',
      desc: 'Clean textiles, wearable fabrics',
      avgRate: '₹8 - ₹14 / kg',
      rateValue: 10,
      suggestedItems: ['Denim jeans', 'Cotton shirts', 'Bed linens']
    },
    {
      id: 'e-waste',
      name: 'E-Waste',
      icon: 'e-waste',
      desc: 'Gadgets, cables, phones, batteries',
      avgRate: '₹40 - ₹120 / kg',
      rateValue: 65,
      suggestedItems: ['Dead mobile phones', 'Chargers & cables', 'Keyboards']
    },
    {
      id: 'other',
      name: 'Other',
      icon: 'other',
      desc: 'Mixed dry recyclable waste',
      avgRate: '₹8 - ₹12 / kg',
      rateValue: 10,
      suggestedItems: ['Mixed dry paper', 'Packaging foam']
    }
  ],

  collectors: [
    {
      id: 'col-1',
      name: 'Rajesh Kumar',
      agency: 'GreenCycle Logistics Hub',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
      rating: 4.9,
      reviewCount: 148,
      completedCollections: 382,
      distanceKm: 0.8,
      availability: 'available', // available | busy | offline
      phone: '+91 98112 34567',
      serviceArea: 'Sector 3 & 4, Bellandur, HSR Layout',
      workingHours: '08:30 AM - 06:30 PM',
      verified: true,
      acceptedCategories: ['plastic', 'paper', 'metal', 'e-waste'],
      rateCard: 'Plastic: ₹18/kg • Paper: ₹14/kg • Metal: ₹35/kg',
      about: 'Certified waste management partner with digital scale and instant UPI payout. Servicing residential societies since 2021.',
      reviews: [
        { author: 'Meera S.', rating: 5, date: 'Yesterday', text: 'Extremely punctual, used digital scales and paid via UPI on the spot!' },
        { author: 'Vikram Patel', rating: 5, date: '3 days ago', text: 'Polite and cleared out 15kg of paper and plastic smoothly.' }
      ]
    },
    {
      id: 'col-2',
      name: 'Priya Sharma',
      agency: 'EcoUrban Circular Services',
      avatar: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&auto=format&fit=crop&q=80',
      rating: 4.8,
      reviewCount: 92,
      completedCollections: 240,
      distanceKm: 1.4,
      availability: 'available',
      phone: '+91 97234 56789',
      serviceArea: 'Koramangala, Indiranagar, BTM Layout',
      workingHours: '09:00 AM - 07:00 PM',
      verified: true,
      acceptedCategories: ['plastic', 'paper', 'glass', 'clothes'],
      rateCard: 'Plastic: ₹19/kg • Glass: ₹6/kg • Clothes: ₹12/kg',
      about: 'Focusing on clean recycling and textile repurposing. Transparent weighing with eco certification.',
      reviews: [
        { author: 'Anita Rao', rating: 5, date: '1 week ago', text: 'Very helpful with sorting our household recycling.' }
      ]
    },
    {
      id: 'col-3',
      name: 'Arjun Swaminathan',
      agency: 'CleanCity Tech Recyclers',
      avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&auto=format&fit=crop&q=80',
      rating: 4.7,
      reviewCount: 115,
      completedCollections: 310,
      distanceKm: 2.1,
      availability: 'busy',
      phone: '+91 96321 09876',
      serviceArea: 'Whitefield, Marathahalli, Kadubeesanahalli',
      workingHours: '09:30 AM - 06:00 PM',
      verified: true,
      acceptedCategories: ['metal', 'e-waste', 'plastic'],
      rateCard: 'E-Waste: ₹70/kg • Metal: ₹38/kg • Plastic: ₹17/kg',
      about: 'Specialized in bulk electronic waste disposal, computer scrap, cables, and copper metals.',
      reviews: [
        { author: 'TechLabs Inc.', rating: 5, date: '2 weeks ago', text: 'Handled our office e-waste with formal green certificate.' }
      ]
    },
    {
      id: 'col-4',
      name: 'Suresh Babu',
      agency: 'ReLife Recyclers Coop',
      avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&auto=format&fit=crop&q=80',
      rating: 4.6,
      reviewCount: 64,
      completedCollections: 180,
      distanceKm: 3.5,
      availability: 'offline',
      phone: '+91 95432 10987',
      serviceArea: 'Jayanagar, JP Nagar',
      workingHours: '10:00 AM - 05:00 PM',
      verified: false,
      acceptedCategories: ['paper', 'glass', 'metal', 'other'],
      rateCard: 'Paper: ₹13/kg • Metal: ₹32/kg • Glass: ₹5/kg',
      about: 'Local neighborhood cooperative collection vehicle. Operates regular morning routes.',
      reviews: [
        { author: 'Gopal K.', rating: 4, date: '1 month ago', text: 'Good rates for old newspapers and books.' }
      ]
    }
  ],

  activeRequest: {
    id: 'REQ-8492',
    collectorId: 'col-1',
    collectorName: 'Rajesh Kumar',
    collectorPhone: '+91 98112 34567',
    collectorAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
    wasteType: 'Plastic & Paper Scrap',
    wasteCategory: 'plastic',
    quantity: '8.5 kg',
    scheduledDate: 'Today',
    scheduledTime: '02:00 PM - 02:30 PM',
    pickupAddress: '402 Oakwood Heights, Green Glen Layout',
    paymentMethod: 'UPI Digital Payment',
    estimatedAmount: '₹153.00',
    status: 'on_the_way', // placed -> accepted -> scheduled -> on_the_way -> collected -> completed
    createdTimestamp: '11:20 AM',
    etaMinutes: 12,
    stages: [
      { key: 'placed', label: 'Request Placed', time: '11:20 AM', done: true },
      { key: 'accepted', label: 'Collector Accepted', time: '11:24 AM', done: true },
      { key: 'scheduled', label: 'Pickup Scheduled', time: 'Today, 2:00 PM', done: true },
      { key: 'on_the_way', label: 'Collector On The Way', time: '01:48 PM', done: true, current: true },
      { key: 'collected', label: 'Waste Collected', time: 'Pending', done: false },
      { key: 'completed', label: 'Payment Completed', time: 'Pending', done: false }
    ]
  },

  chatHistory: [
    { id: 'm1', sender: 'collector', text: 'Hello Alex! I have accepted your pickup request for 8.5 kg of Plastic & Paper scrap.', time: '11:25 AM' },
    { id: 'm2', sender: 'user', text: 'Hi Rajesh! That sounds great. Will you be bringing a digital scale?', time: '11:27 AM' },
    { id: 'm3', sender: 'collector', text: 'Yes, absolutely! I carry a calibrated electronic scale with instant weight display.', time: '11:28 AM' },
    { id: 'm4', sender: 'user', text: 'Perfect. I will have the bags ready in the lobby.', time: '11:30 AM' },
    { id: 'm5', sender: 'collector', text: 'Thank you! I am currently heading towards Green Glen Layout now. ETA is around 12 minutes.', time: '01:49 PM' }
  ],

  notifications: [
    {
      id: 'n1',
      title: 'Collector is on the way!',
      desc: 'Rajesh Kumar is arriving in approx 12 mins for your plastic pickup.',
      time: '10m ago',
      type: 'truck',
      unread: true,
      actionScreen: 'tracking'
    },
    {
      id: 'n2',
      title: 'Pickup Confirmed',
      desc: 'Your request REQ-8492 has been scheduled for Today at 02:00 PM.',
      time: '2h ago',
      type: 'calendar',
      unread: true,
      actionScreen: 'tracking'
    },
    {
      id: 'n3',
      title: 'Payment Received: ₹240.00',
      desc: 'Payment for completed pickup REQ-8120 credited via UPI.',
      time: '3 days ago',
      type: 'card',
      unread: false,
      actionScreen: 'payment-history'
    },
    {
      id: 'n4',
      title: 'Review Reminder',
      desc: 'Please rate your recent collection experience with Priya Sharma.',
      time: '4 days ago',
      type: 'star',
      unread: false,
      actionScreen: 'rating'
    }
  ],

  pastRequests: [
    {
      id: 'REQ-8120',
      collector: 'Priya Sharma',
      wasteType: 'Old Clothes & Fabric',
      category: 'clothes',
      quantity: '14.0 kg',
      date: '18 Sep 2026',
      amount: '₹168.00',
      status: 'Completed',
      paymentMethod: 'UPI'
    },
    {
      id: 'REQ-7954',
      collector: 'Rajesh Kumar',
      wasteType: 'Cardboard & Paper Scrap',
      category: 'paper',
      quantity: '22.5 kg',
      date: '05 Sep 2026',
      amount: '₹315.00',
      status: 'Completed',
      paymentMethod: 'Cash on Collection'
    },
    {
      id: 'REQ-7602',
      collector: 'Arjun Swaminathan',
      wasteType: 'Old Electronics & Wiring',
      category: 'e-waste',
      quantity: '4.8 kg',
      date: '22 Aug 2026',
      amount: '₹312.00',
      status: 'Completed',
      paymentMethod: 'UPI'
    }
  ],

  paymentHistory: [
    {
      id: 'TXN-90214',
      date: '18 Sep 2026, 04:15 PM',
      collector: 'Priya Sharma',
      wasteType: 'Old Clothes (14.0 kg)',
      amount: '₹168.00',
      method: 'UPI (GPay)',
      status: 'Completed',
      reference: 'UPI/382948271049'
    },
    {
      id: 'TXN-88412',
      date: '05 Sep 2026, 11:45 AM',
      collector: 'Rajesh Kumar',
      wasteType: 'Cardboard Scrap (22.5 kg)',
      amount: '₹315.00',
      method: 'Cash on Collection',
      status: 'Completed',
      reference: 'CASH-RECEIPT-7954'
    },
    {
      id: 'TXN-85109',
      date: '22 Aug 2026, 03:20 PM',
      collector: 'Arjun Swaminathan',
      wasteType: 'E-Waste (4.8 kg)',
      amount: '₹312.00',
      method: 'UPI (PhonePe)',
      status: 'Completed',
      reference: 'UPI/194829103948'
    }
  ],

  faqs: [
    {
      q: 'How does ReCyclo match me with collectors?',
      a: 'ReCyclo automatically locates certified collectors within your immediate area who specialize in your selected waste category (Plastic, Metal, Paper, etc.) and are currently available for on-demand or scheduled pickup.'
    },
    {
      q: 'How is the waste weighed and valued?',
      a: 'All verified ReCyclo collectors carry portable digital hanging scales. Your waste is weighed in front of you, and the payout amount is calculated instantly according to standard transparent municipal rates.'
    },
    {
      q: 'What payment options are supported?',
      a: 'You can choose between instant digital payout (via UPI / Card / Wallet directly to your linked account) or cash paid by the collector at the moment of collection.'
    },
    {
      q: 'Can I reschedule or cancel a booking?',
      a: 'Yes, you can reschedule or cancel any pickup free of charge before the collector has arrived at your premises by tapping on the booking in "My Requests".'
    },
    {
      q: 'What happens to the waste after collection?',
      a: 'ReCyclo partners with certified material recovery facilities (MRFs) and government-approved recyclers to ensure 100% circular processing and zero illegal landfill dumping.'
    }
  ]
};
