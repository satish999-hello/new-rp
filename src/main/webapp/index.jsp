import React, { useMemo, useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { Search, ShoppingCart, Heart, User, Sparkles, ArrowRight, Star, Laptop, Shirt, Headphones, Footprints, Smartphone, Watch, Menu, Flame, Tag, Mail } from 'lucide-react';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Badge } from '@/components/ui/badge';

const categories = [
  { id: 'phones', name: 'Smartphones', icon: Smartphone, color: 'from-sky-500 to-cyan-400' },
  { id: 'laptops', name: 'Laptops', icon: Laptop, color: 'from-indigo-500 to-violet-500' },
  { id: 'clothing', name: 'Clothing', icon: Shirt, color: 'from-pink-500 to-rose-400' },
  { id: 'gadgets', name: 'Gadgets', icon: Headphones, color: 'from-amber-500 to-orange-400' },
  { id: 'footwear', name: 'Footwear', icon: Footprints, color: 'from-emerald-500 to-lime-400' },
  { id: 'accessories', name: 'Accessories', icon: Watch, color: 'from-fuchsia-500 to-purple-500' },
];

const products = [
  {
    id: 1,
    title: 'iPhone 14 Pro Max',
    price: 1099,
    oldPrice: 1199,
    rating: 5,
    reviews: 128,
    badge: 'New',
    img: 'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?auto=format&fit=crop&w=900&q=80',
    category: 'phones',
  },
  {
    id: 2,
    title: 'MacBook Pro 14”',
    price: 1999,
    rating: 4,
    reviews: 86,
    img: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=900&q=80',
    category: 'laptops',
  },
  {
    id: 3,
    title: 'Apple Watch Series 8',
    price: 349,
    oldPrice: 399,
    rating: 5,
    reviews: 214,
    badge: 'Hot',
    img: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
  },
  {
    id: 4,
    title: 'Nike Air Max 270',
    price: 150,
    rating: 4,
    reviews: 53,
    img: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=900&q=80',
    category: 'footwear',
  },
  {
    id: 5,
    title: 'Sony A7 IV Camera',
    price: 2499,
    rating: 5,
    reviews: 42,
    img: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=900&q=80',
    category: 'gadgets',
  },
  {
    id: 6,
    title: 'Luxury Perfume',
    price: 120,
    rating: 5,
    reviews: 189,
    img: 'https://images.unsplash.com/photo-1541643600914-78b084683601?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
  },
  {
    id: 7,
    title: 'Travel Backpack',
    price: 79,
    oldPrice: 99,
    rating: 4,
    reviews: 67,
    img: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
  },
  {
    id: 8,
    title: 'Sony WH-1000XM5',
    price: 399,
    rating: 5,
    reviews: 156,
    img: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=900&q=80',
    category: 'gadgets',
  },
];

function ProductCard({ product, onAdd }) {
  return (
    <motion.div whileHover={{ y: -6 }} transition={{ type: 'spring', stiffness: 220, damping: 18 }}>
      <Card className="overflow-hidden rounded-3xl border-0 bg-white/80 shadow-[0_18px_50px_rgba(15,23,42,0.08)] backdrop-blur">
        <div className="relative">
          <img src={product.img} alt={product.title} className="h-60 w-full object-cover" />
          {product.badge && (
            <Badge className="absolute left-4 top-4 rounded-full bg-black/80 px-3 py-1 text-white hover:bg-black/80">
              {product.badge}
            </Badge>
          )}
          <button className="absolute right-4 top-4 rounded-full bg-white/90 p-2 shadow-md transition hover:scale-110">
            <Heart className="h-4 w-4 text-slate-700" />
          </button>
        </div>
        <CardContent className="space-y-4 p-5">
          <div className="flex items-center justify-between gap-3">
            <div>
              <p className="mb-1 text-xs font-medium uppercase tracking-[0.18em] text-slate-500">{product.category}</p>
              <h3 className="text-lg font-semibold text-slate-900">{product.title}</h3>
            </div>
          </div>
          <div className="flex items-center gap-1 text-amber-500">
            {Array.from({ length: 5 }).map((_, i) => (
              <Star key={i} className={`h-4 w-4 ${i < Math.round(product.rating) ? 'fill-amber-400' : ''}`} />
            ))}
            <span className="ml-2 text-sm text-slate-500">({product.reviews})</span>
          </div>
          <div className="flex items-end justify-between gap-3">
            <div>
              <div className="text-2xl font-bold text-slate-900">${product.price.toLocaleString()}</div>
              {product.oldPrice ? <div className="text-sm text-slate-400 line-through">${product.oldPrice.toLocaleString()}</div> : null}
            </div>
            <Button onClick={() => onAdd(product.id)} className="rounded-2xl bg-slate-950 px-5 hover:bg-slate-800">
              Add to cart
            </Button>
          </div>
        </CardContent>
      </Card>
    </motion.div>
  );
}

export default function NexusShopRedesign() {
  const [query, setQuery] = useState('');
  const [activeCategory, setActiveCategory] = useState('all');
  const [cartCount, setCartCount] = useState(0);
  const [timeLeft, setTimeLeft] = useState({ days: 1, hours: 8, minutes: 36, seconds: 12 });

  useEffect(() => {
    const target = new Date(Date.now() + ((24 + 8) * 60 + 36) * 60 * 1000);
    const timer = setInterval(() => {
      const diff = target.getTime() - Date.now();
      if (diff <= 0) {
        clearInterval(timer);
        setTimeLeft({ days: 0, hours: 0, minutes: 0, seconds: 0 });
        return;
      }
      setTimeLeft({
        days: Math.floor(diff / (24 * 60 * 60 * 1000)),
        hours: Math.floor((diff / (60 * 60 * 1000)) % 24),
        minutes: Math.floor((diff / (60 * 1000)) % 60),
        seconds: Math.floor((diff / 1000) % 60),
      });
    }, 1000);
    return () => clearInterval(timer);
  }, []);

  const filteredProducts = useMemo(() => {
    const q = query.trim().toLowerCase();
    return products.filter((p) => {
      const matchesSearch = !q || p.title.toLowerCase().includes(q) || p.category.toLowerCase().includes(q);
      const matchesCategory = activeCategory === 'all' || p.category === activeCategory;
      return matchesSearch && matchesCategory;
    });
  }, [query, activeCategory]);

  return (
    <div className="min-h-screen bg-[radial-gradient(circle_at_top_left,_rgba(14,165,233,0.15),_transparent_22%),radial-gradient(circle_at_top_right,_rgba(168,85,247,0.16),_transparent_20%),linear-gradient(180deg,_#f8fbff_0%,_#eef4ff_45%,_#ffffff_100%)] text-slate-900">
      <header className="sticky top-0 z-50 border-b border-white/40 bg-white/70 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center justify-between gap-4 px-4 py-4 lg:px-8">
          <div className="flex items-center gap-3">
            <button className="rounded-2xl border border-slate-200 bg-white p-2 shadow-sm lg:hidden">
              <Menu className="h-5 w-5" />
            </button>
            <div className="flex items-center gap-2 text-xl font-bold tracking-tight">
              <div className="grid h-10 w-10 place-items-center rounded-2xl bg-gradient-to-br from-cyan-400 via-blue-500 to-violet-500 text-white shadow-lg">
                <Sparkles className="h-5 w-5" />
              </div>
              <span>Nexus<span className="text-cyan-500">Shop</span></span>
            </div>
          </div>

          <nav className="hidden items-center gap-7 text-sm font-medium text-slate-700 lg:flex">
            <a className="transition hover:text-cyan-600" href="#">Home</a>
            <a className="transition hover:text-cyan-600" href="#categories">Categories</a>
            <a className="transition hover:text-cyan-600" href="#products">Trending</a>
            <a className="transition hover:text-cyan-600" href="#deals">Deals</a>
            <a className="transition hover:text-cyan-600" href="#about">About</a>
          </nav>

          <div className="hidden min-w-[280px] items-center gap-3 rounded-full border border-white/70 bg-white/80 px-4 py-2 shadow-sm md:flex">
            <Search className="h-4 w-4 text-slate-400" />
            <Input
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Search products, brands, categories..."
              className="border-0 bg-transparent p-0 shadow-none focus-visible:ring-0"
            />
          </div>

          <div className="flex items-center gap-2">
            <button className="rounded-full border border-white/80 bg-white/80 p-2.5 shadow-sm transition hover:scale-105"><User className="h-4 w-4" /></button>
            <button className="rounded-full border border-white/80 bg-white/80 p-2.5 shadow-sm transition hover:scale-105"><Heart className="h-4 w-4" /></button>
            <button className="relative rounded-full border border-white/80 bg-slate-950 p-2.5 text-white shadow-lg transition hover:scale-105">
              <ShoppingCart className="h-4 w-4" />
              <span className="absolute -right-1 -top-1 grid h-5 w-5 place-items-center rounded-full bg-cyan-500 text-[10px] font-bold text-white">{cartCount}</span>
            </button>
          </div>
        </div>
      </header>

      <section className="relative overflow-hidden px-4 pb-10 pt-12 lg:px-8 lg:pb-16 lg:pt-16">
        <div className="mx-auto grid max-w-7xl items-center gap-10 lg:grid-cols-[1.1fr_0.9fr]">
          <div className="space-y-8">
            <Badge className="rounded-full bg-cyan-100 px-4 py-1.5 text-cyan-700 hover:bg-cyan-100">New Season • Premium Wedding & Lifestyle Picks</Badge>
            <div className="space-y-4">
              <h1 className="max-w-3xl text-4xl font-black leading-tight tracking-tight text-slate-950 md:text-6xl">
                A more premium shopping experience, built to <span className="bg-gradient-to-r from-cyan-500 via-blue-500 to-violet-500 bg-clip-text text-transparent">look stunning</span>.
              </h1>
              <p className="max-w-2xl text-lg text-slate-600">
                Discover curated fashion, gadgets, and accessories with sleek visuals, luxury cards, bold gradients, and a modern storefront feel.
              </p>
            </div>
            <div className="flex flex-wrap items-center gap-4">
              <Button size="lg" className="rounded-2xl bg-slate-950 px-6 hover:bg-slate-800">
                Shop now <ArrowRight className="ml-2 h-4 w-4" />
              </Button>
              <Button size="lg" variant="outline" className="rounded-2xl border-slate-300 bg-white/70 px-6 backdrop-blur">
                <Flame className="mr-2 h-4 w-4 text-orange-500" /> Explore flash deals
              </Button>
            </div>
            <div className="grid max-w-xl grid-cols-3 gap-4">
              {[
                ['50K+', 'Happy Shoppers'],
                ['1.2K+', 'Premium Brands'],
                ['24/7', 'Support Desk'],
              ].map(([value, label]) => (
                <Card key={label} className="rounded-3xl border-0 bg-white/65 shadow-[0_12px_40px_rgba(15,23,42,0.06)] backdrop-blur">
                  <CardContent className="p-5 text-center">
                    <div className="text-2xl font-bold text-slate-950">{value}</div>
                    <div className="text-sm text-slate-500">{label}</div>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>

          <motion.div initial={{ opacity: 0, y: 24 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.7 }} className="relative">
            <div className="absolute -left-10 -top-10 h-32 w-32 rounded-full bg-cyan-300/50 blur-3xl" />
            <div className="absolute -bottom-12 -right-8 h-40 w-40 rounded-full bg-violet-300/50 blur-3xl" />
            <div className="relative overflow-hidden rounded-[32px] border border-white/50 bg-white/50 shadow-[0_26px_90px_rgba(15,23,42,0.12)] backdrop-blur-xl">
              <img
                src="https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?auto=format&fit=crop&w=1400&q=80"
                alt="Featured shopping collection"
                className="h-[520px] w-full object-cover"
              />
              <div className="absolute inset-x-0 bottom-0 bg-gradient-to-t from-slate-950/80 via-slate-900/20 to-transparent p-6 text-white">
                <div className="mb-3 flex items-center gap-2 text-sm text-cyan-200"><Sparkles className="h-4 w-4" /> Trending this week</div>
                <h3 className="text-2xl font-bold">Wedding Collections • Luxe Essentials</h3>
                <p className="mt-2 max-w-md text-sm text-white/80">Elegant picks with elevated UI treatment and premium visual hierarchy.</p>
              </div>
            </div>
          </motion.div>
        </div>
      </section>

      <section id="categories" className="mx-auto max-w-7xl px-4 py-10 lg:px-8">
        <div className="mb-6 flex flex-col gap-3 md:flex-row md:items-end md:justify-between">
          <div>
            <p className="mb-2 text-sm font-semibold uppercase tracking-[0.22em] text-cyan-600">Categories</p>
            <h2 className="text-3xl font-bold tracking-tight">Shop by vibe, not just by product</h2>
          </div>
          <p className="max-w-2xl text-slate-600">Each category uses colorful gradient icons, spacious cards, and better spacing to make the storefront feel cleaner and more premium.</p>
        </div>

        <div className="grid gap-5 sm:grid-cols-2 xl:grid-cols-3">
          {categories.map((cat, i) => {
            const Icon = cat.icon;
            const active = activeCategory === cat.id;
            return (
              <motion.button
                key={cat.id}
                initial={{ opacity: 0, y: 14 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ delay: i * 0.05 }}
                onClick={() => setActiveCategory(active ? 'all' : cat.id)}
                className={`group relative overflow-hidden rounded-[28px] p-[1px] text-left ${active ? 'bg-gradient-to-r from-cyan-500 to-violet-500' : 'bg-white/70'}`}
              >
                <div className={`rounded-[27px] border border-white/70 bg-white/85 p-6 shadow-[0_12px_40px_rgba(15,23,42,0.06)] backdrop-blur transition ${active ? 'bg-slate-950 text-white' : 'hover:-translate-y-1'}`}>
                  <div className={`mb-5 inline-flex rounded-2xl bg-gradient-to-r ${cat.color} p-4 text-white shadow-lg`}><Icon className="h-6 w-6" /></div>
                  <h3 className="text-xl font-semibold">{cat.name}</h3>
                  <p className={`mt-2 text-sm ${active ? 'text-slate-300' : 'text-slate-500'}`}>Tap to {active ? 'clear the filter' : 'explore curated picks'} in this category.</p>
                </div>
              </motion.button>
            );
          })}
        </div>
      </section>

      <section id="products" className="mx-auto max-w-7xl px-4 py-10 lg:px-8">
        <div className="mb-6 flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
          <div>
            <p className="mb-2 text-sm font-semibold uppercase tracking-[0.22em] text-violet-600">Trending Products</p>
            <h2 className="text-3xl font-bold tracking-tight">Best sellers with a richer card layout</h2>
          </div>
          <div className="flex flex-wrap gap-2">
            <Button variant={activeCategory === 'all' ? 'default' : 'outline'} className={`rounded-full ${activeCategory === 'all' ? 'bg-slate-950' : 'bg-white'}`} onClick={() => setActiveCategory('all')}>All</Button>
            {categories.map((cat) => (
              <Button key={cat.id} variant={activeCategory === cat.id ? 'default' : 'outline'} className={`rounded-full ${activeCategory === cat.id ? 'bg-slate-950' : 'bg-white'}`} onClick={() => setActiveCategory(cat.id)}>{cat.name}</Button>
            ))}
          </div>
        </div>

        <div className="mb-8 flex items-center gap-3 rounded-3xl border border-white/70 bg-white/75 p-4 shadow-sm backdrop-blur md:hidden">
          <Search className="h-4 w-4 text-slate-400" />
          <Input value={query} onChange={(e) => setQuery(e.target.value)} placeholder="Search products..." className="border-0 bg-transparent p-0 shadow-none focus-visible:ring-0" />
        </div>

        <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
          {filteredProducts.map((product) => (
            <ProductCard key={product.id} product={product} onAdd={() => setCartCount((c) => c + 1)} />
          ))}
        </div>
        {filteredProducts.length === 0 && (
          <div className="mt-10 rounded-3xl border border-dashed border-slate-300 bg-white/60 p-10 text-center text-slate-500">No products match your search/filter.</div>
        )}
      </section>

      <section id="deals" className="mx-auto max-w-7xl px-4 py-10 lg:px-8">
        <div className="overflow-hidden rounded-[36px] bg-slate-950 text-white shadow-[0_30px_100px_rgba(15,23,42,0.24)]">
          <div className="grid items-stretch lg:grid-cols-[1fr_0.95fr]">
            <div className="relative min-h-[360px] overflow-hidden">
              <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=1400&q=80" alt="Flash sale laptop" className="h-full w-full object-cover" />
              <div className="absolute inset-0 bg-gradient-to-r from-black/20 via-transparent to-transparent" />
            </div>
            <div className="space-y-6 p-8 md:p-10 lg:p-12">
              <div className="inline-flex items-center gap-2 rounded-full bg-white/10 px-4 py-1.5 text-sm text-cyan-200"><Tag className="h-4 w-4" /> Flash Sale</div>
              <div>
                <h2 className="text-3xl font-bold md:text-4xl">MacBook Air M2</h2>
                <p className="mt-3 max-w-lg text-slate-300">Thin, light, powerful — and presented in a cinematic promo section with better contrast, cleaner spacing, and stronger call-to-action emphasis.</p>
              </div>
              <div className="grid grid-cols-4 gap-3">
                {[
                  ['Days', timeLeft.days],
                  ['Hours', String(timeLeft.hours).padStart(2, '0')],
                  ['Mins', String(timeLeft.minutes).padStart(2, '0')],
                  ['Secs', String(timeLeft.seconds).padStart(2, '0')],
                ].map(([label, value]) => (
                  <div key={label} className="rounded-3xl border border-white/10 bg-white/10 p-4 text-center backdrop-blur">
                    <div className="text-2xl font-bold">{value}</div>
                    <div className="text-xs uppercase tracking-[0.16em] text-slate-300">{label}</div>
                  </div>
                ))}
              </div>
              <div className="flex items-center gap-4">
                <div>
                  <div className="text-4xl font-black">$999</div>
                  <div className="text-sm text-slate-400 line-through">$1,199</div>
                </div>
                <Badge className="rounded-full bg-rose-500 px-3 py-1 text-white hover:bg-rose-500">17% OFF</Badge>
              </div>
              <div className="flex flex-wrap gap-3">
                <Button size="lg" className="rounded-2xl bg-cyan-400 px-6 text-slate-950 hover:bg-cyan-300" onClick={() => setCartCount((c) => c + 1)}>
                  Buy now
                </Button>
                <Button size="lg" variant="outline" className="rounded-2xl border-white/20 bg-transparent text-white hover:bg-white/10">
                  Save for later
                </Button>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-10 lg:px-8">
        <div className="mb-6 text-center">
          <p className="mb-2 text-sm font-semibold uppercase tracking-[0.22em] text-emerald-600">Testimonials</p>
          <h2 className="text-3xl font-bold tracking-tight">What visitors love about the new look</h2>
        </div>
        <div className="grid gap-6 lg:grid-cols-3">
          {[
            'Fast shipping and excellent support. The premium card design makes browsing feel more polished.',
            'The new gradients, larger images, and cleaner spacing make the storefront look high-end.',
            'Loved the flash sale section and the category cards — everything feels modern and easy to scan.',
          ].map((quote, i) => (
            <Card key={i} className="rounded-[30px] border-0 bg-white/80 shadow-[0_16px_40px_rgba(15,23,42,0.08)] backdrop-blur">
              <CardContent className="p-7">
                <div className="mb-4 flex items-center gap-1 text-amber-500">{Array.from({ length: 5 }).map((_, idx) => <Star key={idx} className="h-4 w-4 fill-amber-400" />)}</div>
                <p className="text-slate-700">“{quote}”</p>
                <div className="mt-5 flex items-center gap-3">
                  <div className="grid h-11 w-11 place-items-center rounded-full bg-gradient-to-br from-cyan-400 to-violet-400 font-bold text-white">{['A', 'M', 'R'][i]}</div>
                  <div>
                    <div className="font-semibold text-slate-900">Customer {i + 1}</div>
                    <div className="text-sm text-slate-500">Verified buyer</div>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </section>

      <section id="about" className="mx-auto max-w-7xl px-4 py-10 lg:px-8">
        <div className="rounded-[36px] border border-white/60 bg-gradient-to-r from-slate-950 to-slate-900 p-8 text-white shadow-[0_24px_80px_rgba(15,23,42,0.22)] md:p-12">
          <div className="grid gap-8 lg:grid-cols-[1.2fr_0.8fr] lg:items-center">
            <div>
              <p className="mb-2 text-sm font-semibold uppercase tracking-[0.22em] text-cyan-300">Stay in the loop</p>
              <h2 className="text-3xl font-bold tracking-tight md:text-4xl">Subscribe for exclusive drops and premium offers</h2>
              <p className="mt-3 max-w-2xl text-slate-300">This redesigned newsletter block uses stronger contrast, larger typography, rounded inputs, and a cleaner CTA layout.</p>
            </div>
            <div className="rounded-[28px] bg-white/10 p-4 backdrop-blur">
              <div className="flex flex-col gap-3 sm:flex-row">
                <div className="flex flex-1 items-center gap-3 rounded-2xl bg-white/95 px-4 py-3 text-slate-700">
                  <Mail className="h-4 w-4 text-slate-400" />
                  <input className="w-full bg-transparent outline-none placeholder:text-slate-400" placeholder="Enter your email" />
                </div>
                <Button className="rounded-2xl bg-cyan-400 px-5 text-slate-950 hover:bg-cyan-300">Subscribe</Button>
              </div>
            </div>
          </div>
        </div>
      </section>

      <footer className="border-t border-white/60 px-4 py-8 text-slate-600 lg:px-8">
        <div className="mx-auto flex max-w-7xl flex-col gap-5 md:flex-row md:items-center md:justify-between">
          <div>
            <div className="text-lg font-bold text-slate-900">Nexus<span className="text-cyan-500">Shop</span></div>
            <div className="text-sm">Modern e-commerce UI redesign with richer visuals, glass cards, bold gradients, and improved spacing.</div>
          </div>
          <div className="flex items-center gap-3 text-sm">
            <a href="#" className="transition hover:text-cyan-600">About</a>
            <a href="#" className="transition hover:text-cyan-600">Support</a>
            <a href="#" className="transition hover:text-cyan-600">Shipping</a>
            <a href="#" className="transition hover:text-cyan-600">Contact</a>
          </div>
        </div>
      </footer>
    </div>
  );
}
