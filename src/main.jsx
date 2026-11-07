import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './App.jsx';
import './styles.css';
class AppBoundary extends React.Component { constructor(p){super(p);this.state={error:null}} static getDerivedStateFromError(error){return {error}} componentDidCatch(error,info){console.error('Sơn Tự Online render error',error,info)} render(){if(this.state.error)return <div style={{minHeight:'100vh',background:'#11160f',color:'#f2dfb7',padding:30,fontFamily:'sans-serif'}}><h1>Sơn Tự Online</h1><h2>Không thể khởi tạo giao diện</h2><p>{String(this.state.error)}</p><button onClick={()=>location.reload()}>Tải lại</button></div>;return this.props.children}}
const el=document.getElementById('root'); if(el) createRoot(el).render(<AppBoundary><React.StrictMode><App/></React.StrictMode></AppBoundary>);