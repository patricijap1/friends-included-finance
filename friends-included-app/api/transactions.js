import { createTransaction } from "./_core.js";
export default async function handler(req,res){if(req.method!=="POST")return res.status(405).json({error:"Method not allowed."});try{res.status(201).json({record:await createTransaction(req.body)})}catch(e){res.status(400).json({error:e.message})}}
