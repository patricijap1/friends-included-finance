import { decide } from "./_core.js";
export default async function handler(req,res){if(req.method!=="POST")return res.status(405).json({error:"Method not allowed."});try{res.status(200).json({record:await decide(req.body)})}catch(e){res.status(400).json({error:e.message})}}
