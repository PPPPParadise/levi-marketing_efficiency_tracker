import { UserDetail } from './user-detail';

export class UserResponse {
    status: boolean;
    access_token: string;
    user_details: UserDetail[];
}