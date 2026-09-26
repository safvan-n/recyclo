/**
 * ReCyclo Handcrafted SVG Icon System
 * Strict compliance with design specifications:
 * - Default: Crisp OUTLINE with 2px stroke, rounded joins & caps
 * - Active: PRIMARY-COLOUR FILLED / active state treatment
 * - Unified stroke weight, 24x24 coordinate space, harmonious geometry
 */

const Icons = {
  // Renders an icon by name, supporting { active, size, className, color }
  get(name, { active = false, size = 24, className = '', color = 'currentColor' } = {}) {
    const strokeWidth = 2;
    const fillStyle = active ? 'currentColor' : 'none';
    const activeClass = active ? 'app-icon--filled is-active' : 'app-icon--outline';
    const combinedClass = `app-icon ${activeClass} ${className}`.trim();

    let paths = '';

    switch (name) {
      // ---------- Navigation Icons ----------
      case 'home':
        if (active) {
          paths = `<path d="M3 10.25L12 3l9 7.25V20a1.5 1.5 0 0 1-1.5 1.5H4.5A1.5 1.5 0 0 1 3 20V10.25z" fill="currentColor" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                   <path d="M9 21v-7a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v7" fill="#FFFFFF" stroke="#FFFFFF" stroke-width="${strokeWidth}"/>`;
        } else {
          paths = `<path d="M3 10.25L12 3l9 7.25V20a1.5 1.5 0 0 1-1.5 1.5H4.5A1.5 1.5 0 0 1 3 20V10.25z" fill="none" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                   <path d="M9 21v-7a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v7" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        }
        break;

      case 'requests':
        if (active) {
          paths = `<rect x="4" y="4" width="16" height="17" rx="2.5" fill="currentColor" stroke="currentColor" stroke-width="${strokeWidth}"/>
                   <path d="M9 2h6a1 1 0 0 1 1 1v1H8V3a1 1 0 0 1 1-1z" fill="#FFFFFF" stroke="#FFFFFF" stroke-width="1.5"/>
                   <path d="M8 10h8M8 14h5" stroke="#FFFFFF" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        } else {
          paths = `<rect x="4" y="4" width="16" height="17" rx="2.5" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>
                   <path d="M9 2h6a1 1 0 0 1 1 1v1H8V3a1 1 0 0 1 1-1z" stroke="currentColor" stroke-width="1.5"/>
                   <path d="M8 10h8M8 14h5" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        }
        break;

      case 'plus':
      case 'add-waste':
        paths = `<path d="M12 5v14M5 12h14" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>`;
        break;

      case 'collectors':
      case 'truck':
        if (active) {
          paths = `<path d="M1 4h13v12H1V4z" fill="currentColor" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                   <path d="M14 8h4l3 3v5h-7V8z" fill="currentColor" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                   <circle cx="6" cy="18.5" r="2.5" fill="#FFFFFF" stroke="currentColor" stroke-width="${strokeWidth}"/>
                   <circle cx="17" cy="18.5" r="2.5" fill="#FFFFFF" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        } else {
          paths = `<path d="M1 4h13v12H1zM14 8h4l3 3v5h-7V8z" fill="none" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                   <circle cx="6" cy="18.5" r="2.5" stroke="currentColor" stroke-width="${strokeWidth}"/>
                   <circle cx="17" cy="18.5" r="2.5" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        }
        break;

      case 'profile':
      case 'user':
        if (active) {
          paths = `<circle cx="12" cy="7" r="4.5" fill="currentColor" stroke="currentColor" stroke-width="${strokeWidth}"/>
                   <path d="M4 20.5c0-4 3.5-6.5 8-6.5s8 2.5 8 6.5" fill="currentColor" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        } else {
          paths = `<circle cx="12" cy="7" r="4.5" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>
                   <path d="M4 20.5c0-4 3.5-6.5 8-6.5s8 2.5 8 6.5" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        }
        break;

      // ---------- Waste Category Icons ----------
      case 'plastic':
        paths = `<path d="M8 2h8v2H8V2z" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round"/>
                 <path d="M9 4v2.5L6 9v11a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V9l-3-2.5V4" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                 <path d="M9 13h6M9 17h6" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="1.5" stroke-linecap="round"/>`;
        break;

      case 'paper':
        paths = `<path d="M5 3a2 2 0 0 1 2-2h7l5 5v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V3z" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M14 1v6h6" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M9 12h6M9 16h4" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        break;

      case 'metal':
        paths = `<rect x="3" y="6" width="18" height="12" rx="2" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <circle cx="8" cy="12" r="2" fill="${active ? '#FFFFFF' : 'currentColor'}"/>
                 <circle cx="16" cy="12" r="2" fill="${active ? '#FFFFFF' : 'currentColor'}"/>`;
        break;

      case 'glass':
        paths = `<path d="M8 2h8M9 2v4l-4 7v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-7l-4-7V2" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                 <path d="M10 13c1 1 3 1 4 0" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="1.5" stroke-linecap="round"/>`;
        break;

      case 'clothes':
        paths = `<path d="M6 3l6 3 6-3 3 5-3 2v11a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2V10L3 8l3-5z" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>`;
        break;

      case 'e-waste':
        paths = `<rect x="3" y="4" width="18" height="12" rx="2" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M8 20h8M12 16v4" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round"/>
                 <path d="M8 9h2v2H8V9zm6 0h2v2h-2V9z" fill="${active ? '#FFFFFF' : 'currentColor'}"/>`;
        break;

      case 'other':
        paths = `<path d="M12 2l8 4.5v11L12 22l-8-4.5v-11L12 2z" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                 <circle cx="12" cy="12" r="3" fill="${active ? '#FFFFFF' : 'currentColor'}"/>`;
        break;

      // ---------- Action & Utility Icons ----------
      case 'bell':
        if (active) {
          paths = `<path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" fill="currentColor" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                   <path d="M13.73 21a2 2 0 0 1-3.46 0" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        } else {
          paths = `<path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9" fill="none" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                   <path d="M13.73 21a2 2 0 0 1-3.46 0" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        }
        break;

      case 'camera':
        paths = `<path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <circle cx="12" cy="13" r="4" fill="${active ? '#FFFFFF' : 'none'}" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}"/>`;
        break;

      case 'gallery':
      case 'image':
        paths = `<rect x="3" y="3" width="18" height="18" rx="3" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <circle cx="8.5" cy="8.5" r="1.5" fill="${active ? '#FFFFFF' : 'currentColor'}"/>
                 <path d="M21 15l-5-5L5 21" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        break;

      case 'chat':
      case 'message':
        paths = `<path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>`;
        break;

      case 'phone':
        paths = `<path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>`;
        break;

      case 'search':
        paths = `<circle cx="11" cy="11" r="7.5" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M21 21l-4.35-4.35" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        break;

      case 'location':
      case 'map-pin':
        paths = `<path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                 <circle cx="12" cy="10" r="3" fill="${active ? '#FFFFFF' : 'none'}" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}"/>`;
        break;

      case 'calendar':
        paths = `<rect x="3" y="4" width="18" height="18" rx="2" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M16 2v4M8 2v4M3 10h18" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        break;

      case 'clock':
        paths = `<circle cx="12" cy="12" r="9" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M12 6v6l4 2" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        break;

      case 'card':
      case 'credit-card':
        paths = `<rect x="2" y="5" width="20" height="14" rx="2.5" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M2 10h20" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}"/>
                 <path d="M6 15h4" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        break;

      case 'cash':
        paths = `<rect x="2" y="6" width="20" height="12" rx="2" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <circle cx="12" cy="12" r="2.5" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}"/>
                 <path d="M6 12h.01M18 12h.01" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="2" stroke-linecap="round"/>`;
        break;

      case 'star':
        paths = `<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" ${active ? 'fill="#F59E0B" stroke="#F59E0B"' : 'fill="none" stroke="currentColor"'} stroke-width="${strokeWidth}" stroke-linejoin="round"/>`;
        break;

      case 'check':
        paths = `<polyline points="20 6 9 17 4 12" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>`;
        break;

      case 'shield-check':
      case 'verified':
        paths = `<path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>
                 <path d="M9 12l2 2 4-4" stroke="${active ? '#FFFFFF' : 'currentColor'}" stroke-width="${strokeWidth}" stroke-linecap="round" stroke-linejoin="round"/>`;
        break;

      case 'chevron-right':
        paths = `<polyline points="9 18 15 12 9 6" fill="none" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round" stroke-linejoin="round"/>`;
        break;

      case 'chevron-left':
      case 'arrow-left':
        paths = `<polyline points="15 18 9 12 15 6" fill="none" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round" stroke-linejoin="round"/>`;
        break;

      case 'close':
      case 'x':
        paths = `<line x1="18" y1="6" x2="6" y2="18" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round"/>
                 <line x1="6" y1="6" x2="18" y2="18" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        break;

      case 'share':
        paths = `<circle cx="18" cy="5" r="3" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <circle cx="6" cy="12" r="3" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <circle cx="18" cy="19" r="3" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <line x1="8.59" y1="13.51" x2="15.42" y2="17.49" stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <line x1="15.41" y1="6.51" x2="8.59" y2="10.49" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        break;

      case 'filter':
        paths = `<polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3" fill="none" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linejoin="round"/>`;
        break;

      case 'leaf':
      case 'recycle':
        paths = `<path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.48 19 2c1 2 2 4.18 2 8 0 5.5-4.78 10-10 10Z" ${active ? 'fill="currentColor"' : 'fill="none"'} stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        break;

      case 'settings':
        paths = `<circle cx="12" cy="12" r="3" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        break;

      case 'help':
        paths = `<circle cx="12" cy="12" r="10" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>
                 <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3M12 17h.01" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round"/>`;
        break;

      case 'logout':
        paths = `<path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9" fill="none" stroke="currentColor" stroke-width="${strokeWidth}" stroke-linecap="round" stroke-linejoin="round"/>`;
        break;

      default:
        paths = `<circle cx="12" cy="12" r="9" fill="none" stroke="currentColor" stroke-width="${strokeWidth}"/>`;
        break;
    }

    return `<svg class="${combinedClass}" width="${size}" height="${size}" viewBox="0 0 24 24" fill="${fillStyle}">${paths}</svg>`;
  }
};
