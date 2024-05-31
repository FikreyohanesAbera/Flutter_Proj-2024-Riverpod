import {
    Controller,
    Post,
    Body,
    Get,
    Res,
    Req,
    UseGuards
  } from '@nestjs/common';
  import { Request, Response } from 'express';
  import { AuthService } from '../../application/auth/auth.service';
  import { JwtAuthGuard } from '../../auth/JwtAuthGuard';
  import { AdminAuthGuard } from '../../auth/AdminAuthGuard'; 

  
  
  
  @Controller("/auth")
  export class AuthController {
    constructor(private readonly authService: AuthService) {}
  
    @Post('signup')
    async createUser(@Body('username') name: string,@Body('email') email: string, @Body('password') password: string){
        console.log("hejrekj");
        const resp = await this.authService.createUser(
            name,
            email,
            password,
        );
        return resp;


    }
    
  
    @Post("login")
    async login(@Body('email') email: string, @Body('password') password: string, @Res({passthrough: true}) response: Response) {
        console.log("aha");

        const jwt = await this.authService.login(email,password);
        response.cookie("jwt",jwt,{httpOnly: true});

        return {
            message: "success",
            token: jwt
        };
    }
    @Get("/user")
    @UseGuards(JwtAuthGuard)
    async getUser(@Req() request){
        console.log("came here");
        const cookie = request.headers.token;
    
        if (!cookie){
            return {
                status: "error"
            }
        };
         const res = (await this.authService.getUser(cookie));
         console.log(res);
         return {
            status: "success",
            id: res.id.toString(),
            name: res.name,
            email: res.email
         }

    }

    @Get("/logout")
    async logout(@Res({passthrough:true}) res: Response){
        res.clearCookie('jwt');
        return {"okay":"okay"};

    }
    @Post("/admin")
    async verifyAdmin(@Body("name") name: string, @Body("password") password:string){
        const res = await this.authService.verifyAdmin(name,password);
        console.log(res);
        return res

    }
    @Post("/changeusername")
    @UseGuards(JwtAuthGuard)
    async changeUsername(@Body("username") name: string,@Body("id") id: string){
    
        console.log("rrrrrrrrrrrrrrsssssssrrrrrr");
        return this.authService.changeUsername(name,id);

    }
 


    @Get("/adminInfo")
    async getAdmin(){
        await this.authService.getAdmin();
    }
    

  }
  